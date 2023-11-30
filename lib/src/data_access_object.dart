import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'booru_client.dart';
import 'exception/booru_excpetion.dart';
import 'resource.dart';

part 'dao/comment_data_access_object.dart';
part 'dao/post_data_access_object.dart';
part 'dao/tag_data_access_object.dart';
part 'dao/user_data_access_object.dart';

abstract base class DataAccessObject<T extends Resource> {
  final BooruClient client;

  String get host => client.host;

  final String _endpoint;

  const DataAccessObject(this.client, this._endpoint);

  /// Return a list of [T]s.
  @mustBeOverridden
  Future<List<T>> index();
}
