import 'package:servicesplatform/models/design_item_models.dart';

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
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    List<DesignItem> parseDesignList(dynamic data) {
      if (data is! List) return const [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(DesignItem.fromJson)
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

      preferences: List<String>.from(json['preferences'] ?? const []),
    );
  }
  ProfileModel copyWith({
    List<DesignItem>? likedDesigns,
    List<DesignItem>? recentDesigns,
    List<DesignItem>? suggestDesigns,
    List<DesignItem>? buyDesigns,
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
    );
  }
}
