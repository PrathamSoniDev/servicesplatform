import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_model.dart';
import 'theme_parser.dart';

class AppThemeBuilder {
  static ThemeData build(ThemeResponse theme) {
    final colors = theme.colors;
    final fonts = theme.fonts;

    Color c(String key) => ThemeParser.parseColorToken(colors[key]);

    final brightness =
        theme.mode == 'dark' ? Brightness.dark : Brightness.light;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,

      scaffoldBackgroundColor: c('background'),
      primaryColor: c('primary'),
      dividerColor: c('border'),

      textTheme: TextTheme(
        headlineLarge: GoogleFonts.getFont(
          fonts['primaryFont'],
          color: c('textPrimary'),
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.getFont(
          fonts['secondaryFont'],
          color: c('textSecondary'),
        ),
        labelLarge: GoogleFonts.getFont(
          fonts['buttonFont'] ?? fonts['primaryFont'],
          color: c('white'),
          fontWeight: FontWeight.w600,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c('primary'),
          foregroundColor: c('white'),
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: c('primary'),
        brightness: brightness,
      ),
    );
  }
}
