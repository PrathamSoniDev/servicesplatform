import 'package:servicesplatform/models/design_item_models.dart';
import 'package:servicesplatform/models/blog_model.dart'; // Ensure this is imported

class ProfileModel {
  final String? userId;
  final String? name;
  final String? email;
  final String? profileImg;
  final String? role;

  final List<DesignItem> likedDesigns;
  final List<DesignItem> recentDesigns;
  final List<String> preferences;
  final List<DesignItem> suggestDesigns;
  final List<DesignItem> buyDesigns;
  
  // --- ADDED BLOG LISTS ---
  final List<BlogModel> likedBlogs;
  final List<BlogModel> recentBlogs;

  ProfileModel({
    this.userId,
    this.name,
    this.email,
    this.profileImg,
    this.role,
    this.likedDesigns = const [],
    this.recentDesigns = const [],
    this.preferences = const [],
    this.suggestDesigns = const [],
    this.buyDesigns = const [],
    this.likedBlogs = const [], // Default
    this.recentBlogs = const [], // Default
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Helper for Designs
    List<DesignItem> parseDesignList(dynamic data) {
      if (data is! List) return const [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(DesignItem.fromJson)
          .toList();
    }

    // Helper for Blogs
    List<BlogModel> parseBlogList(dynamic data) {
      if (data is! List) return const [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(BlogModel.fromJson)
          .toList();
    }

    return ProfileModel(
      userId: json['userId']?.toString() ?? json['_id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      profileImg: json['profile_img']?.toString(),
      role: json['role']?.toString(),

      likedDesigns: parseDesignList(json['likedDesigns']),
      recentDesigns: parseDesignList(json['recentViewed']),
      suggestDesigns: parseDesignList(json['suggestDesigns']),
      buyDesigns: parseDesignList(json['buyDesigns']),
      
      // --- MAP BLOGS FROM JSON ---
      likedBlogs: parseBlogList(json['likedBlogs']),
      recentBlogs: parseBlogList(json['recentBlogs']),

      preferences: List<String>.from(json['preferences'] ?? const []),
    );
  }

  ProfileModel copyWith({
    List<DesignItem>? likedDesigns,
    List<DesignItem>? recentDesigns,
    List<DesignItem>? suggestDesigns,
    List<DesignItem>? buyDesigns,
    List<BlogModel>? likedBlogs,
    List<BlogModel>? recentBlogs,
  }) {
    return ProfileModel(
      userId: userId,
      name: name,
      email: email,
      profileImg: profileImg,
      role: role,
      preferences: preferences,
      likedDesigns: likedDesigns ?? this.likedDesigns,
      recentDesigns: recentDesigns ?? this.recentDesigns,
      suggestDesigns: suggestDesigns ?? this.suggestDesigns,
      buyDesigns: buyDesigns ?? this.buyDesigns,
      likedBlogs: likedBlogs ?? this.likedBlogs,
      recentBlogs: recentBlogs ?? this.recentBlogs,
    );
  }
}