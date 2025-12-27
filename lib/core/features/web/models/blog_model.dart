class BlogModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String authorName;
  final DateTime publishedAt;
  final int readMinutes;

  const BlogModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.authorName,
    required this.publishedAt,
    required this.readMinutes,
  });
}
