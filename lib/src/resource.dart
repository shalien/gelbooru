import 'package:meta/meta.dart';

part 'resource/comment.dart';
part 'resource/post.dart';
part 'resource/tag.dart';
part 'resource/user.dart';

abstract base class Resource {
  /// The unique identifier for this resource.
  final int id;

  /// Creates a new [Resource] with the given [id].
  const Resource(this.id);

  /// Creates a new [Resource] from a map object.
  Resource.fromMap(Map<String, dynamic> map) : id = map['id'];

  /// Copy the resource with changed attributes.
  @mustBeOverridden
  Resource copyWith({int id});

  @override
  @mustBeOverridden
  String toString() => 'Resource(id: $id)';

  @override
  @mustBeOverridden
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Resource && other.id == id;
  }

  @override
  @mustBeOverridden
  int get hashCode => id.hashCode;
}
