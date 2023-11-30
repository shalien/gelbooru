import 'package:booru_dart/booru_dart.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  List<BooruClient> booruClients = [];

  setUpAll(() {
    File file = File('test/comment_hosts.txt');

    booruClients =
        file.readAsLinesSync().map((host) => BooruClient(host)).toList();
  });

  test('Comment index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (BooruClient client in booruClients) {
      List<Comment> comments = await client.comments.index();

      if (comments.isNotEmpty) {
        print('Comments from ${client.host}: ${comments.length}');
        expect(comments.first, isA<Comment>());
      }
    }
  }, timeout: Timeout(Duration(seconds: 10)));
}
