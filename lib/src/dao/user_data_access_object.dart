

part of '../data_access_object.dart';

final class UserDataAccessObject extends DataAccessObject<User> {
  const UserDataAccessObject(client) : super(client, 'user');


  /// Return a list of [User]s.
  ///
  /// [limit] The maximum number of users to return.
  /// [pid] The ID of the post to return users for.
  /// [name] The name of the user to return.
  /// [namePattern] The pattern of the name of the user to return.
  @override
  Future<List<User>> index({int limit = 100, int? pid, String? name, String? namePattern}) async {
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

    List<User> users = [];
    for (var element in document.findAllElements('user')) {
      Map<String, dynamic> map = {
        'id': int.parse(element.getAttribute('id') ?? '-1'),
        'username': element.getAttribute('username') ?? '',
        'active': int.parse(element.getAttribute('active') ?? '-1'),
      };

      users.add(User.fromMap(map));
    }

    return users;
  }

}