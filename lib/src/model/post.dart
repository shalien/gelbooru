import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

@immutable
final class Post {
  final int height;
  final int width;

  final int score;

  final Uri fileUrl;

  final int? parentId;

  final Uri sampleUrl;
  final int sampleHeight;
  final int sampleWidth;

  final Uri? previewUrl;
  final int? previewHeight;
  final int? previewWidth;

  final String rating;

  final List<String> tags;

  final int id;

  final double change;

  final String md5;

  final int creatorId;

  final bool hasChildren;

  final String status;

  final String? source;

  final bool hasNotes;

  final bool hasComments;

  Post._({
    required this.height,
    required this.width,
    required this.score,
    required this.fileUrl,
    required this.parentId,
    required this.sampleUrl,
    required this.sampleHeight,
    required this.sampleWidth,
    required this.previewUrl,
    required this.previewHeight,
    required this.previewWidth,
    required this.rating,
    required this.tags,
    required this.id,
    required this.change,
    required this.md5,
    required this.creatorId,
    required this.hasChildren,
    required this.status,
    required this.source,
    required this.hasNotes,
    required this.hasComments,
  });

  factory Post.fromXml(XmlElement xml) {
    return Post._(
      height: int.parse(xml.getAttribute('height')!),
      width: int.parse(xml.getAttribute('width')!),
      score: int.parse(xml.getAttribute('score')!),
      fileUrl: Uri.parse(xml.getAttribute('file_url')!),
      parentId: xml.getAttribute('parent_id') != null &&
              xml.getAttribute('parent_id')!.isNotEmpty
          ? int.parse(xml.getAttribute('parent_id')!)
          : null,
      sampleUrl: Uri.parse(xml.getAttribute('sample_url')!),
      sampleHeight: int.parse(xml.getAttribute('sample_height')!),
      sampleWidth: int.parse(xml.getAttribute('sample_width')!),
      previewUrl: xml.getAttribute('preview_url') != null
          ? Uri.parse(xml.getAttribute('preview_url')!)
          : null,
      previewHeight: xml.getAttribute('preview_height') != null
          ? int.parse(xml.getAttribute('preview_height')!)
          : null,
      previewWidth: xml.getAttribute('preview_width') != null
          ? int.parse(xml.getAttribute('preview_width')!)
          : null,
      rating: xml.getAttribute('rating')!,
      tags: xml.getAttribute('tags')!.split(' '),
      id: int.parse(xml.getAttribute('id')!),
      change: double.parse(xml.getAttribute('change')!),
      md5: xml.getAttribute('md5')!,
      creatorId: int.parse(xml.getAttribute('creator_id')!),
      hasChildren: xml.getAttribute('has_children') == 'true',
      status: xml.getAttribute('status')!,
      source: xml.getAttribute('source'),
      hasNotes: xml.getAttribute('has_notes') == 'true',
      hasComments: xml.getAttribute('has_comments') == 'true',
    );
  }
}
