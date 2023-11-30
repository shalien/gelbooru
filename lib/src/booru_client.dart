import 'package:http/http.dart';

import 'data_access_object.dart';

/// A client for a booru.
class BooruClient extends BaseClient {
  /// The inner client.
  final Client _inner;

  /// The host of the booru.
  final String host;

  /// The comments data access object.
  late CommentDataAccessObject comments;

  /// The posts data access object.
  late PostDataAccessObject posts;

  /// The tags data access object.
  late TagDataAccessObject tags;

  /// The users data access object.
  late UserDataAccessObject users;

  /// Create a new [BooruClient].
  ///
  /// [host] The host of the booru.
  BooruClient(this.host, {Client? inner}) : _inner = inner ?? Client() {
    comments = CommentDataAccessObject(this);
    posts = PostDataAccessObject(this);
    tags = TagDataAccessObject(this);
    users = UserDataAccessObject(this);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    return _inner.send(request);
  }
}
