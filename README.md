A universal package for connectiong ot various gelbooru based imageboards. 


## Features

- Tested on the most populars gelbooru's imageboards !
- Mapping to Dart objects from API responses

## Getting started

Run the following command:

```bash
$ dart pub add gelbooru
```

## Usage

```dart

import 'package:gelbooru/gelbooru.dart';

void main() async {
  
  var host = Uri.parse('https://gelbooru.com');
  
  final client = GelbooruClient(host);
  final posts = await client.posts.index();
  
  for (final post in posts) {
    print(post.fileUrl);
  }
  
}

```

## Additional information

The package isn't conceived to actually detect if the imageboard is Gelbooru based.