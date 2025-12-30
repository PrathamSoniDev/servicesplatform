import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_model.dart';
import 'theme_parser.dart';

class AppThemeBuilder {
  static ThemeData build(ThemeResponse theme) {
    final colors = theme.colors;
    final fonts = theme.fonts;

    Color c(String key) => ThemeParser.parseColorToken(colors[key]);

    TextStyle font(
      String? name, {
      Color? color,
      double? size,
      FontWeight? weight,
    }) {
      if (name == null || name.isEmpty) {
        return TextStyle(color: color, fontSize: size, fontWeight: weight);
      }

      try {
        return GoogleFonts.getFont(
          name,
          color: color,
          fontSize: size,
          fontWeight: weight,
        );
      } catch (_) {
        return TextStyle(
          fontFamily: name,
          color: color,
          fontSize: size,
          fontWeight: weight,
        );
      }
    }

    final brightness =
        theme.mode == 'dark' ? Brightness.dark : Brightness.light;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,

      scaffoldBackgroundColor: c('background'),
      primaryColor: c('primary'),
      dividerColor: c('border'),

      appBarTheme: AppBarTheme(
        backgroundColor: c('surface'),
        foregroundColor: c('textPrimary'),
        titleTextStyle: font(
          fonts['primaryFont'],
          color: c('textPrimary'),
          size: 20,
          weight: FontWeight.w600,
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: font(
          fonts['primaryFont'],
          color: c('textPrimary'),
          size: 48,
          weight: FontWeight.bold,
        ),
        bodyLarge: font(fonts['secondaryFont'], color: c('textPrimary')),
        bodyMedium: font(fonts['secondaryFont'], color: c('textSecondary')),
        labelLarge: font(
          fonts['buttonFont'] ?? fonts['primaryFont'],
          color: c('white'),
          weight: FontWeight.w600,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c('primary'),
          foregroundColor: c('white'),
          textStyle: font(
            fonts['buttonFont'] ?? fonts['primaryFont'],
            weight: FontWeight.w600,
          ),
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: c('primary'),
        brightness: brightness,
      ),
    );
  }
}
