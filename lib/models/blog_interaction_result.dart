class BlogInteractionResult {
  final String blogId;
  final bool isLiked;
  final bool isBookmarked;

  BlogInteractionResult({
    required this.blogId,
    required this.isLiked,
    required this.isBookmarked,
  });

  factory BlogInteractionResult.fromJson(Map<String, dynamic> json) {
    return BlogInteractionResult(
      blogId: json['blogId'],
      isLiked: json['isLiked'] ?? false,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
}
