import 'package:booru_dart/booru_dart.dart';
import 'package:test/test.dart';

void main() {
  test('XBooru', () async {
    final String host = 'rule34.xxx';

    final client = BooruClient(host);

    final List<Post>? posts = await client.getPosts(tags: ['dogs']);

    if (posts == null) {
      throw Exception('Posts is null');
    }

    for (var element in posts) {
      print(element.id);
    }

    expect(posts, isNotEmpty);
  });

  test('Count posts', () async {
    final String host = 'rule34.xxx';

    final client = BooruClient(host);

    final int? count = await client.getCount(['anal']);

    expect(count, isNotNull);
  });

  test('Max Pages response', () async {
    final String host = 'rule34.xxx';

    final client = BooruClient(host);

    final int maxPage = await client.getMaxPage(['anal']);

    final List<Post>? posts =
        await client.getPosts(tags: ['anal'], pid: maxPage);

    print('$maxPage ${posts?.length}');

    expect(posts, isNotNull);
  });

  test('Find a post with children', () async {
    final String host = 'rule34.xxx';

    final client = BooruClient(host);

    final List<Post>? posts = await client.getPosts(tags: ['anal']);

    if (posts == null) {
      throw Exception('Posts is null');
    }

    List<Post> withChildren =
        posts.where((element) => element.hasChildren).toList();

    print(withChildren.first.id);

    expect(posts, isNotEmpty);
  });

  test('Find a post by parent id', () async {
    final String host = 'rule34.xxx';

    final client = BooruClient(host);

    final int id = 1017047;

    final List<Post>? posts = await client.getPostsByParentId(id);

    if (posts == null) {
      throw Exception('Posts is null');
    }

    posts.sort((a, b) => a.id.compareTo(b.id));

    for (var post in posts) {
      print(post.fileUrl);
    }

    expect(posts, isNotEmpty);
  });
}
