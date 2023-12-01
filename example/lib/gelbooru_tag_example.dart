import 'package:gelbooru/gelbooru.dart';

Future<void> main() async {
  List<String> tags = ['sort:random', 'boobs'];

  GelbooruClient client = GelbooruClient(Uri.parse('https://gelbooru.com'));

  List<Post> posts = await client.posts.index(tags: tags);

  for (Post post in posts) {
    print(post.fileUrl);
  }
}
