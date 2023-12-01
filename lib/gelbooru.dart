/// A universal package for connectiong ot various gelbooru based imageboards.
/// 
/// 
/// ## Features
/// 
/// - Tested on the most populars gelbooru's imageboards !
/// - Mapping to Dart objects from API responses
/// 
/// ## Getting started
/// 
/// Run the following command:
/// 
/// ```bash
/// $ dart pub add gelbooru
/// ```
/// 
/// ## Usage
/// 
/// ```dart
/// 
/// import 'package:gelbooru/gelbooru.dart';
/// 
/// void main() async {
///   
///   const host = 'https://gelbooru.com';
///   
///   final client = GelbooruClient(host);
///   final posts = await client.posts.index();
///   
///   for (final post in posts) {
///     print(post.fileUrl);
///   }
///   
/// }
/// 
/// ```
/// 
/// ## Additional information
/// 
/// The package isn't conceived to actually detect if the imageboard is Gelbooru based.
library;

export 'src/gelbooru_client.dart';
export 'src/data_access_object.dart';
export 'src/exception/booru_excpetion.dart';
export 'src/resource.dart';
