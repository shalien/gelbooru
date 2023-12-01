import 'package:gelbooru/gelbooru.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  List<GelbooruClient> booruClients = [];

  setUpAll(() {
    File file = File('test/post_hosts.txt');

    booruClients =
        file.readAsLinesSync().map((host) => GelbooruClient(host)).toList();
  });

  test('Post index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/post_hosts.txt');
    }

    for (GelbooruClient client in booruClients) {
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
      throw Exception('No hosts found in test/post_hosts.txt');
    }

    for (GelbooruClient client in booruClients) {
      int count = await client.posts.count(tags: ['sort:random anal']);

      if (count > 0) {
        print('Post from ${client.host}: $count');
        expect(count, isA<int>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 30)));
}
