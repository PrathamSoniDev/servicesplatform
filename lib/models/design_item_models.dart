class DesignItem {
  final String id;
  final String categoryId;
  final String? title;
  final String? subtitle;
  final String? bannerImage;
  final List<String> images;
  final int likesCount;
  final int viewsCount;
  final List<String> colors;
  final Map<String, dynamic> fonts;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DesignItem({
    required this.id,
    required this.categoryId,
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
    return DesignItem(
      id: json['id'] ?? json['_id'],
      categoryId:
          json['categoryId'] is Map
              ? json['categoryId']['id'] ?? json['categoryId']['_id']
              : json['categoryId'],
      title: json['title'] ?? "",
      subtitle: json['subtitle'] ?? "",
      bannerImage: json['bannerImage'] ?? "",
      images: List<String>.from(json['images'] ?? []),
      likesCount: json['likesCount'] ?? 0,
      viewsCount: json['viewsCount'] ?? 0,
      colors: List<String>.from(json['colors'] ?? []),
      fonts: Map<String, dynamic>.from(json['fonts'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// 🔹 Convert model back to JSON (for POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
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

// Updated to 9 items for a 3x3 grid
final List<DesignItem> designsData = [
  DesignItem(
    id: "demo-1",
    categoryId: "ui-ux",
    title: "Abstract Flow",
    subtitle: "Modern minimal interface architecture.",
    bannerImage:
        "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564",
    images: [
      "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564",
    ],
    likesCount: 842,
    viewsCount: 1200,
    colors: ["#1E293B", "#6366F1", "#F8FAFC"],
    fonts: {"title": "Montserrat", "body": "Inter"},
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now(),
  ),

  DesignItem(
    id: "demo-2",
    categoryId: "dashboard",
    title: "Cyber Vision",
    subtitle: "Futuristic dashboard concepts.",
    bannerImage:
        "https://images.unsplash.com/photo-1633167606207-d840b5070fc2?q=80&w=2564",
    images: [
      "https://images.unsplash.com/photo-1633167606207-d840b5070fc2?q=80&w=2564",
    ],
    likesCount: 1100,
    viewsCount: 2400,
    colors: ["#020617", "#22D3EE", "#A855F7"],
    fonts: {"title": "Poppins", "body": "Roboto"},
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now(),
  ),

  DesignItem(
    id: "demo-3",
    categoryId: "branding",
    title: "Gradient Mesh",
    subtitle: "Exploring organic color transitions.",
    bannerImage:
        "https://images.unsplash.com/photo-1614850523296-d8c1af93d400?q=80&w=2564",
    images: [
      "https://images.unsplash.com/photo-1614850523296-d8c1af93d400?q=80&w=2564",
    ],
    likesCount: 930,
    viewsCount: 1800,
    colors: ["#EC4899", "#8B5CF6", "#0EA5E9"],
    fonts: {"title": "DM Sans", "body": "Inter"},
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    updatedAt: DateTime.now(),
  ),

  DesignItem(
    id: "demo-4",
    categoryId: "ui-effects",
    title: "Glassmorphism",
    subtitle: "Soft UI and frosted glass effects.",
    bannerImage:
        "https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=2564",
    images: [
      "https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=2564",
    ],
    likesCount: 2100,
    viewsCount: 5200,
    colors: ["#FFFFFF", "#CBD5E1", "#0F172A"],
    fonts: {"title": "SF Pro", "body": "SF Pro"},
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    updatedAt: DateTime.now(),
  ),

  DesignItem(
    id: "demo-5",
    categoryId: "dark-ui",
    title: "Dark Mode",
    subtitle: "Optimizing contrast for night viewing.",
    bannerImage:
        "https://images.unsplash.com/photo-1618556450991-2f1af64e8191?q=80&w=2564",
    images: [
      "https://images.unsplash.com/photo-1618556450991-2f1af64e8191?q=80&w=2564",
    ],
    likesCount: 750,
    viewsCount: 1100,
    colors: ["#020617", "#334155", "#E5E7EB"],
    fonts: {"title": "Inter", "body": "Inter"},
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
  ),
];
