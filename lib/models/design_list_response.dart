import 'design_item_models.dart';

class DesignListResponse {
  final List<DesignItem> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  DesignListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory DesignListResponse.fromJson(Map<String, dynamic> json) {
    return DesignListResponse(
      items:
          (json['items'] as List).map((e) => DesignItem.fromJson(e)).toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
