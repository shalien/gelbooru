
import 'package:gelbooru/gelbooru.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  List<GelbooruClient> booruClients = [];

  setUpAll(() {
    File file = File('test/comment_hosts.txt');

    booruClients =
        file.readAsLinesSync().map((host) => GelbooruClient(host)).toList();
  });

  test('Comment index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (GelbooruClient client in booruClients) {
      List<Comment> comments = await client.comments.index();

      if (comments.isNotEmpty) {
        print('Comments from ${client.host}: ${comments.length}');
        expect(comments.first, isA<Comment>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 10)));
}
