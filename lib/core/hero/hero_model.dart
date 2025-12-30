class HeroModel {
  final String id;
  final String key;
  final String headingText;
  final String? subHeadingText,
      primaryButtonText,
      secondaryButtonText,
      ctaPrimary,
      ctaSecondary;
  final String assetUrl;
  final bool isActive;
  final bool isGif;
  final bool isImage;
  final bool isVideo;
  final bool isLottie;
  final String? gradientText;
  final bool isContentCenter, isContentRight, isContentLeft;
  HeroModel({
    required this.id,
    required this.key,
    required this.headingText,
    required this.assetUrl,
    required this.isActive,
    required this.isGif,
    required this.isImage,
    required this.isVideo,
    required this.isLottie,
    this.subHeadingText,
    this.gradientText,
    required this.isContentCenter,
    required this.isContentLeft,
    required this.isContentRight,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.ctaPrimary,
    this.ctaSecondary,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'],
      key: json['key'],
      headingText: json['headingText'],
      subHeadingText: json['subHeadingText'],
      assetUrl: json['assetUrl'],
      isActive: json['isActive'] ?? true,
      isGif: json['isGif'] ?? false,
      isImage: json['isImage'] ?? false,
      isVideo: json['isVideo'] ?? false,
      isLottie: json['isLottie'] ?? false,
      gradientText: json['gradientText'],
      isContentCenter: json['isContentCenter'] ?? false,
      isContentLeft: json['isContentLeft'] ?? false,
      isContentRight: json['isContentRight'] ?? false,
      primaryButtonText: json['primaryButtonText'] ?? "",
      secondaryButtonText: json['secondaryButtonText'] ?? "",
      ctaPrimary: json['ctaPrimary'] ?? "",
      ctaSecondary: json['ctaSecondary'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'key': key,
    'headingText': headingText,
    'subHeadingText': subHeadingText,
    'assetUrl': assetUrl,
    'isActive': isActive,
    'isGif': isGif,
    'isImage': isImage,
    'isVideo': isVideo,
    'isLottie': isLottie,
    'gradientText': gradientText,
    'isContentCenter': isContentCenter,
    'isContentRight': isContentRight,
    'isContentLeft': isContentLeft,
    'primaryButtonText': primaryButtonText,
    'secondaryButtonText': secondaryButtonText,
    'ctaPrimary': ctaPrimary,
    'ctaSecondary': ctaSecondary,
  };
}
