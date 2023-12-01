import 'package:gelbooru/gelbooru.dart';

void main() async {
  var host = Uri.parse('https://gelbooru.com');

  final client = GelbooruClient(host);
  final posts = await client.posts.index();

  for (final post in posts) {
    print(post.fileUrl);
  }
}
