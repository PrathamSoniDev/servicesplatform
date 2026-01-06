import 'package:equatable/equatable.dart';

class BlogModel extends Equatable {
  final String id;
  final String title;
  final String shortDescription;
  final String? placeholderImage;
  final String categoryId;
  final String categoryName;
  final String author;
  final int readingTime;
  final DateTime createdAt;

  /// Interactions
  final bool isLiked;
  final bool isBookmarked;

  /// Content & Comments
  final List<BlogContentBlock> content;
  final List<BlogComment> comments;

  const BlogModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.categoryId,
    required this.categoryName,
    required this.author,
    required this.readingTime,
    required this.createdAt,
    this.placeholderImage,
    this.isLiked = false,
    this.isBookmarked = false,
    this.content = const [],
    this.comments = const [],
  });

  // ───────────────────────────── copyWith ─────────────────────────────

  BlogModel copyWith({
    String? id,
    String? title,
    String? shortDescription,
    String? placeholderImage,
    String? categoryId,
    String? categoryName,
    String? author,
    int? readingTime,
    DateTime? createdAt,
    bool? isLiked,
    bool? isBookmarked,
    List<BlogContentBlock>? content,
    List<BlogComment>? comments,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      placeholderImage: placeholderImage ?? this.placeholderImage,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      author: author ?? this.author,
      readingTime: readingTime ?? this.readingTime,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      content: content ?? this.content,
      comments: comments ?? this.comments,
    );
  }

  // ───────────────────────────── JSON ─────────────────────────────

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      placeholderImage: json['placeholderImage'],
      categoryId: json['category']?['id'] ?? '',
      categoryName: json['category']?['name'] ?? '',
      author: json['author'],
      readingTime: json['readingTime'],
      createdAt: DateTime.parse(json['createdAt']),
      isLiked: json['isLiked'] ?? false,
      isBookmarked: json['isBookmarked'] ?? false,
      content:
          (json['content'] as List? ?? [])
              .map((e) => BlogContentBlock.fromJson(e))
              .toList(),
      comments:
          (json['comments'] as List? ?? [])
              .map((e) => BlogComment.fromJson(e))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    shortDescription,
    placeholderImage,
    categoryId,
    categoryName,
    author,
    readingTime,
    createdAt,
    isLiked,
    isBookmarked,
    content,
    comments,
  ];
}

class BlogContentBlock {
  final bool isContentLeft;
  final bool isContentRight;
  final bool isContentCenter;

  final String? assetUrl;
  final BlogAssetType assetType;
  final String? text;

  const BlogContentBlock({
    this.isContentLeft = false,
    this.isContentRight = false,
    this.isContentCenter = true,
    this.assetUrl,
    this.assetType = BlogAssetType.none,
    this.text,
  });

  factory BlogContentBlock.fromJson(Map<String, dynamic> json) {
    return BlogContentBlock(
      isContentLeft: json['isContentLeft'] ?? false,
      isContentRight: json['isContentRight'] ?? false,
      isContentCenter: json['isContentCenter'] ?? true,
      assetUrl: json['assetUrl'],
      assetType: BlogAssetTypeX.fromString(json['assetType']),
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
    'isContentLeft': isContentLeft,
    'isContentRight': isContentRight,
    'isContentCenter': isContentCenter,
    'assetUrl': assetUrl,
    'assetType': assetType.value,
    'text': text,
  };
}

class BlogComment {
  final String id;
  final String userId;
  final String? parentId;
  final String? name;
  final String? avatar;
  final int? rating;
  final String comment;
  final bool isApproved;
  final bool isReported;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BlogComment({
    required this.id,
    required this.userId,
    this.parentId,
    this.name,
    this.avatar,
    this.rating,
    required this.comment,
    required this.isApproved,
    required this.isReported,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogComment.fromJson(Map<String, dynamic> json) {
    return BlogComment(
      id: json['_id'],
      userId: json['userId'] is Map ? json['userId']['_id'] : json['userId'],
      parentId: json['parentId'],
      name: json['name'],
      avatar: json['avatar'],
      rating: json['rating'],
      comment: json['comment'],
      isApproved: json['isApproved'] ?? true,
      isReported: json['isReported'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'parentId': parentId,
    'name': name,
    'avatar': avatar,
    'rating': rating,
    'comment': comment,
    'isApproved': isApproved,
    'isReported': isReported,
  };
}

enum BlogAssetType { image, video, gif, lottie, none }

extension BlogAssetTypeX on BlogAssetType {
  String get value => toString().split('.').last;

  static BlogAssetType fromString(String? value) {
    switch (value) {
      case 'image':
        return BlogAssetType.image;
      case 'video':
        return BlogAssetType.video;
      case 'gif':
        return BlogAssetType.gif;
      case 'lottie':
        return BlogAssetType.lottie;
      default:
        return BlogAssetType.none;
    }
  }
}
