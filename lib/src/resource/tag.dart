part of '../resource.dart';

/// A tag on a booru.
final class Tag extends Resource {
  /// The name of the tag.
  final String? name;

  /// The number of posts with this tag.
  final int count;

  /// The type of tag.
  final int type;

  /// The number of posts with ambiguous tags.
  final bool? ambiguous;

  Tag(this.name, this.count, this.type, this.ambiguous, super.id);

  @override
  Tag.fromMap(super.map)
      : name = map['name'],
        count = map['count'],
        type = map['type'],
        ambiguous = map['ambiguous'],
        super.fromMap();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag &&
        other.name == name &&
        other.count == count &&
        other.type == type &&
        other.ambiguous == ambiguous;
  }

  @override
  Tag copyWith(
      {int? id, String? name, int? count, int? type, bool? ambiguous}) {
    return Tag(
      name ?? this.name,
      count ?? this.count,
      type ?? this.type,
      ambiguous ?? this.ambiguous,
      id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      count.hashCode ^
      type.hashCode ^
      ambiguous.hashCode;

  @override
  String toString() {
    return 'Tag(id: $id, name: $name, count: $count, type: $type, ambiguous: $ambiguous)';
  }
}
