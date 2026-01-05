class ProfileModel {
  final String? userId;
  final String? name;
  final String? email;
  final String? profileImg;
  final String? role;

  final List<String> likedDesigns;
  final List<String> recentDesigns;
  final List<String> preferences;
  final List<String> suggestDesigns;
  final List<String> buyDesigns;

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
    return ProfileModel(
      userId: json['userId']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      profileImg: json['profile_img']?.toString(),
      role: json['role']?.toString(),

      likedDesigns: List<String>.from(json['likedDesigns'] ?? const []),

      recentDesigns: List<String>.from(json['recentViewed'] ?? const []),

      preferences: List<String>.from(json['preferences'] ?? const []),

      suggestDesigns: List<String>.from(json['suggestDesigns'] ?? const []),

      buyDesigns: List<String>.from(json['buyDesigns'] ?? const []),
    );
  }
}
