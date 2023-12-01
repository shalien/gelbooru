
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

  test('Tag index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (GelbooruClient client in booruClients) {
      List<Tag> tags = await client.tags.index();

      if (tags.isNotEmpty) {
        print('Tags from ${client.host}: ${tags.length}');
        expect(tags.first, isA<Tag>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 30)));
}
