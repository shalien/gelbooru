part of '../resource.dart';

/// A comment on a post.
final class Comment extends Resource {
  /// The date the comment was created.
  final DateTime createdAt;

  /// The creator of the comment.
  final String creator;

  /// The body of the comment.
  final String body;

  /// The id of the creator of the comment.
  final int creatorId;

  /// Create a [Comment].
  const Comment(
      this.createdAt, this.creator, this.body, this.creatorId, super.id);

  /// Create a [Comment] from a map.
  @override
  Comment.fromMap(super.map)
      : createdAt = DateTime.parse(map['created_at']),
        creator = map['creator'],
        body = map['body'],
        creatorId = map['creator_id'],
        super.fromMap();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.createdAt == createdAt &&
        other.creator == creator &&
        other.body == body &&
        other.creatorId == creatorId;
  }

  @override
  Comment copyWith({
    int? id,
    DateTime? createdAt,
    String? creator,
    String? body,
    int? creatorId,
  }) {
    return Comment(createdAt ?? this.createdAt, creator ?? this.creator,
        body ?? this.body, creatorId ?? this.creatorId, id ?? this.id);
  }

  @override
  int get hashCode =>
      super.hashCode ^
      createdAt.hashCode ^
      creator.hashCode ^
      body.hashCode ^
      creatorId.hashCode;

  @override
  String toString() {
    return 'Comment(id: $id, createdAt: $createdAt, creator: $creator, body: $body,creatorId: $creatorId)';
  }
}
