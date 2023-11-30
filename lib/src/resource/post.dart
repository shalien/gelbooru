part of '../resource.dart';

/// A post on a booru.
@immutable
final class Post extends Resource {

  /// The date and time the post was created.
  final DateTime createdAt;

  /// The score of the post.
  final int? score;

  /// The width of the image in pixels.
  final int width;

  /// The height of the image in pixels.
  final int height;

  /// The md5 hash of the post.
  final String md5;

  /// The directory part url of the image.
  final String directory;

  /// The name of the image.
  final String image;

  /// The rating of the post.
  final String rating;

  /// The source of the post.
  final String? source;

  /// The change in the post.
  final int change;

  /// The id of the owner of the post.
  final int owner;

  /// The id of the creator of the post.
  final int creatorId;

  /// The id of the parent post.
  final int? parentId;

  /// The sample of the post.
  final int sample;

  /// The height of the preview image in pixels.
  final int? previewHeight;

  /// The width of the preview image in pixels.
  final int? previewWidth;

  /// Whether the post has notes.
  final bool hasNotes;

  /// Whether the post has comments.
  final bool hasComments;

  /// The url of the image.
  final Uri fileUrl;

  /// The url of the preview image.
  final Uri? previewUrl;

  /// The tags of the post.
  final List<String> tags;

  /// The url of the sample image.
  final Uri sampleUrl;

  /// The height of the sample image in pixels.
  final int sampleHeight;

  /// The width of the sample image in pixels.
  final int sampleWidth;

  /// The status of the post.
  final String status;

  final int postLocked;

  bool get isLocked => postLocked == 1;

  /// Whether the post has children.
  final bool hasChildren;

  /// Creates a [Post] instance.
  const Post(
      this.height,
      this.width,
      this.score,
      this.fileUrl,
      this.parentId,
      this.sampleUrl,
      this.sampleHeight,
      this.sampleWidth,
      this.previewUrl,
      this.previewHeight,
      this.previewWidth,
      this.rating,
      this.tags,
      this.change,
      this.md5,
      this.creatorId,
      this.hasChildren,
      this.status,
      this.source,
      this.hasNotes,
      this.hasComments,
      this.createdAt,
      this
      super.id);

  /// Creates a [Post] instance from a map.
  Post.fromMap(super.map) :
      map['height'] as int,
      map['width'] as int,
      map['score'] as int?,
      Uri.parse(map['file_url'] as String),
      map['parent_id'] as int?,
      Uri.parse(map['sample_url'] as String),
      map['sample_height'] as int,
      map['sample_width'] as int,
      Uri.parse(map['preview_url'] as String),
      map['preview_height'] as int,
      map['preview_width'] as int,
      map['rating'] as String,
      (map['tags'] as String).split(' '),
      map['change'] as int,
      map['md5'] as String,
      map['creator_id'] as int,
      map['has_children'] as bool,
      map['status'] as String,
      map['source'] as String?,
      map['has_notes'] as bool,
      map['has_comments'] as bool,
      map['id'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.height == height &&
        other.width == width &&
        other.score == score &&
        other.fileUrl == fileUrl &&
        other.parentId == parentId &&
        other.sampleUrl == sampleUrl &&
        other.sampleHeight == sampleHeight &&
        other.sampleWidth == sampleWidth &&
        other.previewUrl == previewUrl &&
        other.previewHeight == previewHeight &&
        other.previewWidth == previewWidth &&
        other.rating == rating &&
        other.tags == tags &&
        other.id == id &&
        other.change == change &&
        other.md5 == md5 &&
        other.creatorId == creatorId &&
        other.hasChildren == hasChildren &&
        other.status == status &&
        other.source == source &&
        other.hasNotes == hasNotes &&
        other.hasComments == hasComments;
  }

  @override
  Resource copyWith(
      {int? id,
      int? parentId,
      String? source,
      Uri? previewUrl,
      int? previewHeight,
      int? previewWidth,
      Uri? sampleUrl,
      int? sampleHeight,
      int? sampleWidth,
      Uri? fileUrl,
      int? height,
      int? width,
      int? score,
      int? change,
      String? md5,
      int? creatorId,
      bool? hasChildren,
      String? status,
      bool? hasNotes,
      bool? hasComments,
      String? rating,
      List<String>? tags}) {
    return Post(
      height ?? this.height,
      width ?? this.width,
      score ?? this.score,
      fileUrl ?? this.fileUrl,
      parentId ?? this.parentId,
      sampleUrl ?? this.sampleUrl,
      sampleHeight ?? this.sampleHeight,
      sampleWidth ?? this.sampleWidth,
      previewUrl ?? this.previewUrl,
      previewHeight ?? this.previewHeight,
      previewWidth ?? this.previewWidth,
      rating ?? this.rating,
      tags ?? this.tags,
      change ?? this.change,
      md5 ?? this.md5,
      creatorId ?? this.creatorId,
      hasChildren ?? this.hasChildren,
      status ?? this.status,
      source ?? this.source,
      hasNotes ?? this.hasNotes,
      hasComments ?? this.hasComments,
      id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      change.hashCode ^
      md5.hashCode ^
      creatorId.hashCode ^
      hasChildren.hashCode ^
      status.hashCode ^
      source.hashCode ^
      hasNotes.hashCode ^
      hasComments.hashCode;

  @override
  String toString() {
    return 'Post(height: $height, width: $width, score: $score, fileUrl: $fileUrl, parentId: $parentId, sampleUrl: $sampleUrl, sampleHeight: $sampleHeight, sampleWidth: $sampleWidth, previewUrl: $previewUrl, previewHeight: $previewHeight, previewWidth: $previewWidth, rating: $rating, tags: $tags, id: $id, change: $change, md5: $md5, creatorId: $creatorId, hasChildren: $hasChildren, status: $status, source: $source, hasNotes: $hasNotes, hasComments: $hasComments)';
  }
}
