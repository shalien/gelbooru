
import 'package:gelbooru/gelbooru.dart';
import 'package:test/test.dart';
import 'dart:io';

import 'package:xml/xml.dart';

void main() {
  List<GelbooruClient> booruClients = [];

  setUpAll(() {
    File file = File('test/post_hosts.txt');

    booruClients =
        file.readAsLinesSync().map((host) => GelbooruClient(host)).toList();
  });

  test('User index', () async {
    if (booruClients.isEmpty) {
      throw Exception('No hosts found in test/comment_hosts.txt');
    }

    for (GelbooruClient client in booruClients) {
      try {
        List<User> users = await client.users.index();

        if (users.isNotEmpty) {
          print('Tags from ${client.host}: ${users.length}');
          expect(users.first, isA<User>());
        }
      } on XmlParserException {
        print('XmlParserException from ${client.host}');
        continue;
      } on XmlTagException {
        print('XmlTagException from ${client.host}');
        continue;
      }
    }
  }, timeout: Timeout(Duration(seconds: 30)));
}
