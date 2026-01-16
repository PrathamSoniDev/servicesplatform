class DesignItem {
  final String id;
  final String categoryId;
  final String? categoryName;
  final String? title;
  final String? subtitle;
  final String? bannerImage;
  final List<String> images;
  final int likesCount;
  final int viewsCount;
  final List<String> colors;
  final String fonts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool? isLiked;

  const DesignItem({
    required this.id,
    required this.categoryId,
    this.categoryName,
    this.isLiked,
    this.title,
    this.subtitle,
    this.bannerImage,
    required this.images,
    required this.likesCount,
    required this.viewsCount,
    required this.colors,
    required this.fonts,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔹 Factory constructor for API response
  factory DesignItem.fromJson(Map<String, dynamic> json) {
    final fontData = json['fonts'];
    final fonts =
        fontData is Map
            ? fontData.values
                .where((v) => v != null && v.toString().trim().isNotEmpty)
                .map((v) => v.toString())
                .join(' / ')
            : fontData?.toString() ?? '';
    return DesignItem(
      id: json['id'] ?? json['_id'],
      categoryId:
          json['categoryId'] is Map
              ? json['categoryId']['id'] ?? json['categoryId']['_id']
              : json['categoryId'],
      categoryName: '',
      title: json['title'] ?? "",
      subtitle: json['subtitle'] ?? "",
      bannerImage: json['bannerImage'] ?? "",
      images: List<String>.from(json['images'] ?? []),
      likesCount: json['likesCount'] ?? 0,
      viewsCount: json['viewsCount'] ?? 0,
      colors: List<String>.from(json['colors'] ?? []),
      fonts: fonts,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// 🔹 Convert model back to JSON (for POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
      'categoryName': categoryName,
      'subtitle': subtitle,
      'bannerImage': bannerImage,
      'images': images,
      'likesCount': likesCount,
      'viewsCount': viewsCount,
      'colors': colors,
      'fonts': fonts,
    };
  }
}

extension DesignItemCopy on DesignItem {
  DesignItem copyWith({String? categoryName, bool? isLiked}) {
    return DesignItem(
      id: id,
      categoryId: categoryId,
      categoryName: categoryName ?? this.categoryName,
      title: title,
      subtitle: subtitle,
      bannerImage: bannerImage,
      images: images,
      likesCount: likesCount,
      viewsCount: viewsCount,
      colors: colors,
      fonts: fonts,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isLiked: isLiked,
    );
  }
}
