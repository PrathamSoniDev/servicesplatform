import 'blog_model.dart';

class PaginatedBlogs {
  final List<BlogModel> items;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginatedBlogs({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginatedBlogs.fromJson(Map<String, dynamic> json) {
    return PaginatedBlogs(
      items: (json['items'] as List).map((e) => BlogModel.fromJson(e)).toList(),
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }
}
