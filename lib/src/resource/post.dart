part of '../resource.dart';

/// A post on a booru.
@immutable
final class Post extends Resource {
  /// The date and time the post was created.
  final String createdAt;

  /// The score of the post.
  final int? score;

  /// The width of the image in pixels.
  final int width;

  /// The height of the image in pixels.
  final int height;

  /// The md5 hash of the post.
  final String md5;

  /// The directory part url of the image.
  final String? directory;

  /// The name of the image.
  final String? image;

  /// The rating of the post.
  final String? rating;

  /// The source of the post.
  final String? source;

  /// The change in the post.
  final int change;

  /// The id of the owner of the post.
  final String? owner;

  /// The id of the creator of the post.
  final int? creatorId;

  /// The id of the parent post.
  final int? parentId;

  /// The sample of the post.
  final int? sample;

  /// The height of the preview image in pixels.
  final int previewHeight;

  /// The width of the preview image in pixels.
  final int previewWidth;

  /// Whether the post has notes.
  final bool hasNotes;

  /// Whether the post has comments.
  final bool hasComments;

  /// The url of the image.
  final Uri fileUrl;

  /// The url of the preview image.
  final Uri previewUrl;

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

  /// Whether the post is locked.
  final int? postLocked;

  /// Whether the post is locked.
  bool get isLocked => postLocked == 1 || postLocked == null;

  /// Whether the post has children.
  final bool hasChildren;

  /// Creates a [Post] instance.
  const Post(
      this.createdAt,
      this.score,
      this.width,
      this.height,
      this.md5,
      this.directory,
      this.image,
      this.rating,
      this.source,
      this.change,
      this.owner,
      this.creatorId,
      this.parentId,
      this.sample,
      this.previewHeight,
      this.previewWidth,
      this.hasNotes,
      this.hasComments,
      this.fileUrl,
      this.previewUrl,
      this.tags,
      this.sampleUrl,
      this.sampleHeight,
      this.sampleWidth,
      this.status,
      this.postLocked,
      this.hasChildren,
      super.id);

  /// Creates a [Post] instance from a map.
  Post.fromMap(super.map)
      : createdAt = map['createdAt'],
        score = map['score'],
        width = map['width'],
        height = map['height'],
        md5 = map['md5'],
        directory = map['directory'],
        image = map['image'],
        rating = map['rating'],
        source = map['source'],
        change = map['change'],
        owner = map['owner'],
        creatorId = map['creatorId'],
        parentId = map['parentId'],
        sample = map['sample'],
        previewHeight = map['previewHeight'],
        previewWidth = map['previewWidth'],
        hasNotes = map['hasNotes'],
        hasComments = map['hasComments'],
        fileUrl = Uri.parse(map['fileUrl']),
        previewUrl = Uri.parse(map['previewUrl']),
        tags = map['tags'].split(' '),
        sampleUrl = Uri.parse(map['sampleUrl']),
        sampleHeight = map['sampleHeight'],
        sampleWidth = map['sampleWidth'],
        status = map['status'],
        postLocked = map['postLocked'],
        hasChildren = map['hasChildren'],
        super.fromMap();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.createdAt == createdAt &&
        other.score == score &&
        other.width == width &&
        other.height == height &&
        other.md5 == md5 &&
        other.directory == directory &&
        other.image == image &&
        other.rating == rating &&
        other.source == source &&
        other.change == change &&
        other.owner == owner &&
        other.creatorId == creatorId &&
        other.parentId == parentId &&
        other.sample == sample &&
        other.previewHeight == previewHeight &&
        other.previewWidth == previewWidth &&
        other.hasNotes == hasNotes &&
        other.hasComments == hasComments &&
        other.fileUrl == fileUrl &&
        other.previewUrl == previewUrl &&
        other.tags == tags &&
        other.sampleUrl == sampleUrl &&
        other.sampleHeight == sampleHeight &&
        other.sampleWidth == sampleWidth &&
        other.status == status &&
        other.postLocked == postLocked &&
        other.hasChildren == hasChildren &&
        other.id == id;
  }

  @override
  Resource copyWith(
      {String? createdAt,
      int? score,
      int? width,
      int? height,
      String? md5,
      String? directory,
      String? image,
      String? rating,
      String? source,
      int? change,
      String? owner,
      int? creatorId,
      int? parentId,
      int? sample,
      int? previewHeight,
      int? previewWidth,
      bool? hasNotes,
      bool? hasComments,
      Uri? fileUrl,
      Uri? previewUrl,
      List<String>? tags,
      Uri? sampleUrl,
      int? sampleHeight,
      int? sampleWidth,
      String? status,
      int? postLocked,
      bool? hasChildren,
      int? id}) {
    return Post(
      createdAt ?? this.createdAt,
      score ?? this.score,
      width ?? this.width,
      height ?? this.height,
      md5 ?? this.md5,
      directory ?? this.directory,
      image ?? this.image,
      rating ?? this.rating,
      source ?? this.source,
      change ?? this.change,
      owner ?? this.owner,
      creatorId ?? this.creatorId,
      parentId ?? this.parentId,
      sample ?? this.sample,
      previewHeight ?? this.previewHeight,
      previewWidth ?? this.previewWidth,
      hasNotes ?? this.hasNotes,
      hasComments ?? this.hasComments,
      fileUrl ?? this.fileUrl,
      previewUrl ?? this.previewUrl,
      tags ?? this.tags,
      sampleUrl ?? this.sampleUrl,
      sampleHeight ?? this.sampleHeight,
      sampleWidth ?? this.sampleWidth,
      status ?? this.status,
      postLocked ?? this.postLocked,
      hasChildren ?? this.hasChildren,
      id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      createdAt.hashCode ^
      score.hashCode ^
      width.hashCode ^
      height.hashCode ^
      md5.hashCode ^
      directory.hashCode ^
      image.hashCode ^
      rating.hashCode ^
      source.hashCode ^
      change.hashCode ^
      owner.hashCode ^
      creatorId.hashCode ^
      parentId.hashCode ^
      sample.hashCode ^
      previewHeight.hashCode ^
      previewWidth.hashCode ^
      hasNotes.hashCode ^
      hasComments.hashCode ^
      fileUrl.hashCode ^
      previewUrl.hashCode ^
      tags.hashCode ^
      sampleUrl.hashCode ^
      sampleHeight.hashCode ^
      sampleWidth.hashCode ^
      status.hashCode ^
      postLocked.hashCode ^
      hasChildren.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'Post(createdAt: $createdAt, score: $score, width: $width, height: $height, md5: $md5, directory: $directory, image: $image, rating: $rating, source: $source, change: $change, owner: $owner, creatorId: $creatorId, parentId: $parentId, sample: $sample, previewHeight: $previewHeight, previewWidth: $previewWidth, hasNotes: $hasNotes, hasComments: $hasComments, fileUrl: $fileUrl, previewUrl: $previewUrl, tags: $tags, sampleUrl: $sampleUrl, sampleHeight: $sampleHeight, sampleWidth: $sampleWidth, status: $status, postLocked: $postLocked, hasChildren: $hasChildren, id: $id)';
  }
}
