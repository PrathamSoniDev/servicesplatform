class ThemeResponse {
  final Map<String, dynamic> colors;
  final Map<String, dynamic> fonts;
  final String mode;

  ThemeResponse({
    required this.colors,
    required this.fonts,
    required this.mode,
  });

  factory ThemeResponse.fromJson(Map<String, dynamic> json) {
    return ThemeResponse(
      colors: json['colors'],
      fonts: json['fonts'],
      mode: json['mode'],
    );
  }
}
