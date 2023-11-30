part of '../data_access_object.dart';

final class CommentDataAccessObject extends DataAccessObject<Comment> {
  CommentDataAccessObject(client) : super(client, 'comment');

  /// Return a list of [Comment]s.
  @override
  Future<List<Comment>> index(
      {int limit = 100, int? pid, String? name, String? namePattern}) async {
    limit = limit.clamp(1, 100);

    Uri uri = Uri.https(super.host, 'index.php', {
      'page': 'dapi',
      's': _endpoint,
      'q': 'index',
      'limit': limit.toString(),
      ...(pid != null ? {'pid': pid.toString()} : {}),
      ...(name != null ? {'name': name} : {}),
      ...(namePattern != null ? {'name_pattern': namePattern} : {}),
    });

    Response response;

    try {
      response = await super.client.get(uri);
    } on ClientException {
      rethrow;
    }

    if (response.statusCode != 200) {
      throw BooruException.fromResponse(response);
    }

    XmlDocument document;
    try {
      document = XmlDocument.parse(response.body);
    } on XmlParserException {
      rethrow;
    } on XmlTagException {
      rethrow;
    }

    List<Comment> comments = [];
    for (var element in document.findAllElements('comment')) {
      Map<String, dynamic> map = {
        'id': int.parse(element.getAttribute('id') ?? '-1'),
        'created_at': element.getAttribute('created_at') ?? '',
        'creator': element.getAttribute('creator') ?? '',
        'body': element.getAttribute('body') ?? '',
        'creator_id': int.parse(element.getAttribute('creator_id') ?? '-1'),
      };

      comments.add(Comment.fromMap(map));
    }

    return comments;
  }
}