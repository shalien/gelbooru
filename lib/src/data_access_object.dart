import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'gelbooru_client.dart';
import 'exception/booru_excpetion.dart';
import 'resource.dart';

part 'dao/comment_data_access_object.dart';
part 'dao/post_data_access_object.dart';
part 'dao/tag_data_access_object.dart';
part 'dao/user_data_access_object.dart';

/// A data access object for a booru.
abstract base class DataAccessObject<T extends Resource> {
  /// The client for the booru.
  final GelbooruClient client;

  /// The endpoint for the booru.
  String get host => client.host.host;

  /// The endpoint for the booru.
  final String _endpoint;

  /// Base constructor for a data access object.
  const DataAccessObject(this.client, this._endpoint);

  /// Return a list of [T]s.
  @mustBeOverridden
  Future<List<T>> index();
}
