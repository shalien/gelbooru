import 'package:booru_dart/booru_dart.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  List<BooruClient> booruClients = [];

  setUpAll(() {
    File file = File('test/post_hosts.txt');

    booruClients =
        file.readAsLinesSync().map((host) => BooruClient(host)).toList();
  });

  test('Post index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (BooruClient client in booruClients) {
      List<Post> posts = await client.posts.index(tags: ['sort:random']);

      if (posts.isNotEmpty) {
        print('Post from ${client.host}: ${posts.length}');
        print(posts.first);
        expect(posts.first, isA<Post>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 30)));

  test('Post count', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (BooruClient client in booruClients) {
      int count = await client.posts.count(tags: ['sort:random anal']);

      if (count > 0) {
        print('Post from ${client.host}: $count');
        expect(count, isA<int>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 30)));
}
