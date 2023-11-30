part of '../data_access_object.dart';

final class PostDataAccessObject extends DataAccessObject<Post> {
  const PostDataAccessObject(client) : super(client, 'post');

  /// Return a list of [Post]s.
  ///
  /// [limit] How many posts you want to retrieve. There is a default limit of 100 posts per request.
  /// [pid] The page number.
  /// [tags] The tags to search for. Any tag combination that works on the web site will work here. This includes all the meta-tags. See [howto:search](https://gelbooru.com/index.php?page=wiki&s=&s=view&id=25921) and [howto:cheatsheet](https://gelbooru.com/index.php?page=wiki&s=&s=view&id=26263) for more information.
  /// [cid] Change ID of the post. This is in Unix time so there are likely others with the same value if updated at the same time.
  /// [id] The post id.
  @override
  Future<List<Post>> index(
      {int limit = 100,
      int? pid,
      List<String>? tags,
      int? cid,
      int? id}) async {
    Uri uri = Uri.https(super.host, 'index.php', {
      'page': 'dapi',
      's': _endpoint,
      'q': 'index',
      'limit': limit.toString(),
      ...(pid != null ? {'pid': pid.toString()} : {}),
      ...(tags != null ? {'tags': tags.join(' ')} : {}),
      ...(cid != null ? {'cid': cid.toString()} : {}),
      ...(id != null ? {'id': id.toString()} : {}),
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

    List<Post> posts = [];

    for (var element in document.findAllElements('post')) {

      Map<String, dynamic> map;

      if(element.attributes.isNotEmpty) {
        map = {
          'id': int.parse(element.getAttribute('id') ?? '-1'),
          'tags': element.getAttribute('tags') ?? '',
          'created_at': element.getAttribute('created_at') ?? '',
          'creator_id': int.parse(element.getAttribute('creator_id') ?? '-1'),
          'change': int.parse(element.getAttribute('change') ?? '-1'),
          'source': element.getAttribute('source') ?? '',
          'score': element.getAttribute('score') == null
              ? null
              : int.tryParse(element.getAttribute('score')!),
          'md5': element.getAttribute('md5') ?? '',
          'file_url': element.getAttribute('file_url') ?? '',
          'is_shown_in_index': element.getAttribute('is_shown_in_index') ?? '',
          'preview_url': element.getAttribute('preview_url') ?? '',
          'preview_width':
          int.parse(element.getAttribute('preview_width') ?? '-1'),
          'preview_height':
          int.parse(element.getAttribute('preview_height') ?? '-1'),
          'actual_preview_width':
          int.parse(element.getAttribute('actual_preview_width') ?? '-1'),
          'actual_preview_height':
          int.parse(element.getAttribute('actual_preview_height') ?? '-1'),
          'sample_url': element.getAttribute('sample_url') ?? '',
          'sample_width': int.parse(
              element.getAttribute('sample_width') ?? '-1'),
          'sample_height':
          int.parse(element.getAttribute('sample_height') ?? '-1'),
          'sample_file_size':
          int.parse(element.getAttribute('sample_file_size') ?? '-1'),
          'jpeg_url': element.getAttribute('jpeg_url') ?? '',
          'jpeg_width': int.parse(element.getAttribute('jpeg_width') ?? '-1'),
          'jpeg_height': int.parse(element.getAttribute('jpeg_height') ?? '-1'),
          'jpeg_file_size':
          int.parse(element.getAttribute('jpeg_file_size') ?? '-1'),
          'rating': element.getAttribute('rating') ?? '',
          'has_children': element.getAttribute('has_children') ?? '',
          'parent_id': element.getAttribute('parent_id') == null
              ? null
              : int.tryParse(element.getAttribute('parent_id')!),
          'status': element.getAttribute('status') ?? '',
          'width': int.parse(element.getAttribute('width') ?? '-1'),
          'height': int.parse(element.getAttribute('height') ?? '-1')
        };
      } else if (element.children.isNotEmpty) {
        map = {
          'id': int.parse(element.getElement('id')!.innerText),
          'tags': element.getElement('tags')!.innerText,
          'created_at': element.getElement('created_at')!.innerText ?? '',
          'creator_id': int.parse(element.getElement('creator_id')!.innerText ?? '-1'),
          'change': int.parse(element.getElement('change')!.innerText ?? '-1'),
          'source': element.getElement('source')!.innerText ?? '',
          'score': element.getElement('score')!.innerText,
          'md5': element.getElement('md5')!.innerText ?? '',
           'file_url': element.getElement('file_url')!.innerText ?? '',
          'preview_url': element.getElement('preview_url')!.innerText ?? '',
          'preview_width':
          int.parse(element.getElement('preview_width')!.innerText ?? '-1'),
          'preview_height':
          int.parse(element.getElement('preview_height')!.innerText ?? '-1'),
          'sample_url': element.getElement('sample_url')!.innerText ?? '',
          'sample_width': int.parse(
              element.getElement('sample_width')!.innerText ?? '-1'),
          'sample_height':
          int.parse(element.getElement('sample_height')!.innerText ?? '-1'),
         'rating': element.getElement('rating')!.innerText ?? '',
          'has_children': element.getElement('has_children')!.innerText ?? '',
          'parent_id': element.getElement('parent_id')!.innerText,
      };
      } else {
        throw Exception('No attributes or children found in post element');
      }

      posts.add(Post.fromMap(map));
    }

    return posts;
  }

  Future<int> count({int limit = 100,
    int? pid,
    List<String>? tags,
    int? cid,
    int? id}) async {
Uri uri = Uri.https(super.host, 'index.php', {
      'page': 'dapi',
      's': _endpoint,
      'q': 'index',
      'limit': limit.toString(),
      'tags': tags?.join(' ') ?? '',
      ...(pid != null ? {'pid': pid.toString()} : {}),
      ...(cid != null ? {'cid': cid.toString()} : {}),
      ...(id != null ? {'id': id.toString()} : {}),
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

    if (document.findAllElements('posts').isEmpty) {
     return -1;
    }

    return int.parse(document.findAllElements('posts').first.getAttribute('count') ?? '-1');
  }
}
