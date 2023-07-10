import 'package:http/http.dart';
import 'package:xml/xml.dart';

import 'model/post.dart';

class BooruClient {
  static final Map<String, BooruClient> _instances = <String, BooruClient>{};

  final Client? _client;

  final String host;

  BooruClient._(this.host, {Client? client}) : _client = client ?? Client();

  factory BooruClient(String host, {Client? client}) {
    if (_instances.containsKey(host)) {
      return _instances[host]!;
    }

    final instance = BooruClient._(host, client: client);
    _instances[host] = instance;
    return instance;
  }

  Future<int?> getCountByTag(String tag) async => await getCount([tag]);

  Future<int?> getCount(List<String> tags) async {
    Uri uri = Uri.https(host, '/index.php', {
      'page': 'dapi',
      's': 'post',
      'q': 'index',
      'limit': '1',
      ...tags.isNotEmpty ? {'tags': tags.join('+')} : {},
    });

    final response = await _client!.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    XmlDocument xml = XmlDocument.parse(response.body);

    var posts = xml.findAllElements('posts');

    if (posts.isEmpty) {
      return null;
    }

    return int.tryParse(posts.first.getAttribute('count') ?? '');
  }

  Future<int> getMaxPageByTag(String tag) async => await getMaxPage([tag]);

  Future<int> getMaxPage(List<String> tags) async {
    Uri uri = Uri.https(host, '/index.php', {
      'page': 'dapi',
      's': 'post',
      'q': 'index',
      'limit': '1',
      ...tags.isNotEmpty ? {'tags': tags.join('+')} : {},
    });

    final response = await _client!.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    XmlDocument xml = XmlDocument.parse(response.body);

    var posts = xml.findAllElements('posts');

    if (posts.isEmpty) {
      return 0;
    }

    return int.tryParse(posts.first.getAttribute('count') ?? '')! ~/ 100;
  }

  Future<List<Post>?> getPosts(
      {int limit = 100,
      int? pid,
      List<String> tags = const [],
      int? cid,
      int? id}) async {
    Uri uri = Uri.https(host, '/index.php', {
      'page': 'dapi',
      's': 'post',
      'q': 'index',
      'limit': limit.clamp(1, 100).toString(),
      ...pid != null ? {'pid': pid.toString()} : {},
      ...tags.isNotEmpty ? {'tags': tags.join('+')} : {},
      ...cid != null ? {'cid': cid.toString()} : {},
      ...id != null ? {'id': id.toString()} : {},
    });

    final response = await _client!.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    XmlDocument xml = XmlDocument.parse(response.body);

    var posts = xml.findAllElements('post');

    if (posts.isEmpty) {
      return null;
    }

    return posts.map((e) => Post.fromXml(e)).toList();
  }

  Future<List<Post>?> getPostsByParentId(int id) {
    return getPosts(tags: ['parent:$id']);
  }
}
