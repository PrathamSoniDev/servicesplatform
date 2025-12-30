import 'package:flutter/material.dart';

class AppThemeProvider extends InheritedWidget {
  final AppThemeTokens tokens;

  const AppThemeProvider({
    super.key,
    required this.tokens,
    required super.child,
  });

  static AppThemeTokens of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppThemeProvider>();

    if (provider == null) {
      return AppThemeTokens(colors: {}, fonts: {});
    }

    return provider.tokens;
  }

  @override
  bool updateShouldNotify(covariant AppThemeProvider oldWidget) {
    return oldWidget.tokens != tokens;
  }
}

class AppThemeTokens {
  final Map<String, dynamic> colors;
  final Map<String, dynamic> fonts;

  AppThemeTokens({required this.colors, required this.fonts});
}
