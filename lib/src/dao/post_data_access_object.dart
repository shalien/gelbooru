part of '../data_access_object.dart';

/// A data access object for [Comment]s.
final class PostDataAccessObject extends DataAccessObject<Post> {
  /// Create a [PostDataAccessObject].
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
      ...(tags != null ? {'tags': tags.join('')} : {}),
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

      if (element.attributes.isNotEmpty) {
        map = {
          'createdAt': element.getAttribute('created_at'),
          'score': element.getAttribute('score') == null ||
                  element.getAttribute('score')!.isEmpty
              ? null
              : int.parse(element.getAttribute('score')!),
          'width': element.getAttribute('width') == null
              ? null
              : int.parse(element.getAttribute('width')!),
          'height': element.getAttribute('height') == null
              ? null
              : int.parse(element.getAttribute('height')!),
          'md5': element.getAttribute('md5')!,
          'directory': element.getElement('directory') == null
              ? null
              : element.getAttribute('directory')!,
          'image': element.getElement('image') == null
              ? null
              : element.getAttribute('image')!,
          'rating': element.getAttribute('rating')!,
          'source': element.getAttribute('source')!,
          'change': element.getAttribute('change') == null
              ? null
              : int.parse(element.getAttribute('change')!),
          'owner': element.getAttribute('owner'),
          'creatorId': element.getAttribute('creator_id') == null
              ? null
              : int.parse(element.getAttribute('creator_id')!),
          'parentId': element.getAttribute('parent_id') == null ||
                  element.getAttribute('parent_id')!.isEmpty
              ? null
              : int.parse(element.getAttribute('parent_id')!),
          'sample': element.getAttribute('sample') == null
              ? null
              : int.parse(element.getAttribute('sample')!),
          'previewHeight': element.getAttribute('preview_height') == null
              ? null
              : int.parse(element.getAttribute('preview_height')!),
          'previewWidth': element.getAttribute('preview_width') == null
              ? null
              : int.parse(element.getAttribute('preview_width')!),
          'hasNotes': element.getAttribute('has_notes') == null
              ? null
              : bool.parse(element.getAttribute('has_notes')!),
          'hasComments': element.getAttribute('has_comments') == null
              ? null
              : bool.parse(element.getAttribute('has_comments')!),
          'fileUrl': element.getAttribute('file_url')!,
          'previewUrl': element.getAttribute('preview_url')!,
          'tags': element.getAttribute('tags')!,
          'sampleUrl': element.getAttribute('sample_url')!,
          'sampleHeight': element.getAttribute('sample_height') == null
              ? null
              : int.parse(element.getAttribute('sample_height')!),
          'sampleWidth': element.getAttribute('sample_width') == null
              ? null
              : int.parse(element.getAttribute('sample_width')!),
          'status': element.getAttribute('status')!,
          'postLocked': element.getAttribute('post_locked') == null
              ? null
              : int.parse(element.getAttribute('post_locked')!),
          'hasChildren': element.getAttribute('has_children') == null
              ? null
              : bool.parse(element.getAttribute('has_children')!),
          'id': element.getAttribute('id') == null
              ? null
              : int.parse(element.getAttribute('id')!),
        };
      } else if (element.children.isNotEmpty) {
        map = {
          'createdAt': element.getElement('created_at')!.innerText,
          'score': element.getElement('score') == null
              ? null
              : int.parse(element.getElement('score')!.innerText),
          'width': element.getElement('width') == null
              ? null
              : int.parse(element.getElement('width')!.innerText),
          'height': element.getElement('height') == null
              ? null
              : int.parse(element.getElement('height')!.innerText),
          'md5': element.getElement('md5')!.innerText,
          'directory': element.getElement('directory')!.innerText,
          'image': element.getElement('image')!.innerText,
          'rating': element.getElement('rating')!.innerText,
          'source': element.getElement('source')!.innerText,
          'change': int.parse(element.getElement('change')!.innerText),
          'owner': element.getElement('owner')!.innerText,
          'creatorId': element.getElement('creator_id') == null
              ? null
              : int.parse(element.getElement('creator_id')!.innerText),
          'parentId': element.getElement('parent_id') == null
              ? null
              : int.parse(element.getElement('parent_id')!.innerText),
          'sample': element.getElement('sample') == null
              ? null
              : int.parse(element.getElement('sample')!.innerText),
          'previewHeight': element.getElement('preview_height') == null
              ? null
              : int.parse(element.getElement('preview_height')!.innerText),
          'previewWidth': element.getElement('preview_width') == null
              ? null
              : int.parse(element.getElement('preview_width')!.innerText),
          'hasNotes': element.getElement('has_notes') == null
              ? null
              : bool.parse(element.getElement('has_notes')!.innerText),
          'hasComments': element.getElement('has_comments') == null
              ? null
              : bool.parse(element.getElement('has_comments')!.innerText),
          'fileUrl': element.getElement('file_url')!.innerText,
          'previewUrl': element.getElement('preview_url')!.innerText,
          'tags': element.getElement('tags')!.innerText,
          'sampleUrl': element.getElement('sample_url')!.innerText,
          'sampleHeight': element.getElement('sample_height') == null
              ? null
              : int.parse(element.getElement('sample_height')!.innerText),
          'sampleWidth': element.getElement('sample_width') == null
              ? null
              : int.parse(element.getElement('sample_width')!.innerText),
          'status': element.getElement('status')!.innerText,
          'postLocked': element.getElement('post_locked') == null
              ? null
              : int.parse(element.getElement('post_locked')!.innerText),
          'hasChildren': element.getElement('has_children') == null
              ? null
              : bool.parse(element.getElement('has_children')!.innerText),
          'id': element.getElement('id') == null
              ? null
              : int.parse(element.getElement('id')!.innerText),
        };
      } else {
        throw Exception('No attributes or children found in post element');
      }

      posts.add(Post.fromMap(map));
    }

    return posts;
  }

  /// Return the number of [Post]s.
  ///
  /// Yhe count will be affected by the request parameters.
  /// [limit] How many posts you want to retrieve. There is a default limit of 100 posts per request.
  /// [pid] The page number.
  /// [tags] list of the tags
  /// [cid] Change ID of the post. This is in Unix time so there are likely others with the same value if updated at the same time.
  /// [id] The post id.
  Future<int> count(
      {int limit = 100,
      int? pid,
      List<String>? tags,
      int? cid,
      int? id}) async {
    limit = limit.clamp(1, 100);

    Uri uri = Uri.https(super.host, 'index.php', {
      'page': 'dapi',
      's': _endpoint,
      'q': 'index',
      'limit': limit.toString(),
      'tags': tags?.join('') ?? '',
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

    return int.parse(
        document.findAllElements('posts').first.getAttribute('count') ?? '-1');
  }
}
