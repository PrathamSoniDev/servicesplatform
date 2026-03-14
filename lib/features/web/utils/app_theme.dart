import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  /// Brand Colors
  static const Color primaryGreen = Color(0xFF00E676);
  static const Color darkBackground = Color(0xFF000000);
  static const Color surfaceGrey = Color(0xFF121212);

  static const Color cardColor = Color(0xFF161616);
  static const Color borderColor = Color(0xFF262626);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);

  /// Spacing
  static const double pagePaddingDesktop = 120;
  static const double pagePaddingTablet = 60;
  static const double pagePaddingMobile = 24;

  /// Text Sizes
  static const double heroTitle = 64;
  static const double sectionTitle = 42;
  static const double cardTitle = 22;
  static const double bodyText = 18;

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    useMaterial3: true,

    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      onPrimary: Colors.black,
      surface: surfaceGrey,
      background: darkBackground,
    ),

    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(

        /// Big Hero Title
        headlineLarge: TextStyle(
          fontSize: heroTitle,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          color: textPrimary,
        ),

        /// Section Heading
        headlineMedium: TextStyle(
          fontSize: sectionTitle,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),

        /// Card Title
        titleLarge: TextStyle(
          fontSize: cardTitle,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),

        /// Body Text
        bodyLarge: TextStyle(
          fontSize: bodyText,
          color: textSecondary,
          height: 1.6,
        ),
      ),
    ),
  );
}