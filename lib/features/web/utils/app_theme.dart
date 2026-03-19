import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Brand Colors (Existing + New Professional Accents)
  static const Color primaryGreen = Color(0xFF27AE60); // Refined Emerald
  static const Color darkBackground = Color(0xFF000000);
  static const Color surfaceGrey = Color(0xFF121212);
  static const Color cardColor = Color(0xFF161616);
  static const Color borderColor = Color(0xFF262626);

  /// NEW: Professional Off-White & Light Theme Colors
  static const Color bgOffWhite = Color(0xFFF8F9FB); 
  static const Color cardLight = Colors.white;
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color textBlack = Color(0xFF1D1D1F); // Apple-style Jet Black
  static const Color textGrey = Color(0xFF6E6E73);

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

  /// DARK THEME (Existing)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      onPrimary: Colors.black,
      surface: surfaceGrey,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: heroTitle, fontWeight: FontWeight.w800, letterSpacing: -1.5, color: textPrimary),
        headlineMedium: TextStyle(fontSize: sectionTitle, fontWeight: FontWeight.bold, color: textPrimary),
        titleLarge: TextStyle(fontSize: cardTitle, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: TextStyle(fontSize: bodyText, color: textSecondary, height: 1.6),
      ),
    ),
  );

  /// NEW: LIGHT THEME (For Off-White Screens)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgOffWhite,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      onPrimary: Colors.white,
      surface: cardLight,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        displayLarge: TextStyle(fontSize: heroTitle, fontWeight: FontWeight.w900, color: textBlack, letterSpacing: -2),
        displayMedium: TextStyle(fontSize: sectionTitle, fontWeight: FontWeight.bold, color: textBlack),
        titleLarge: TextStyle(fontSize: cardTitle, fontWeight: FontWeight.bold, color: textBlack),
        bodyLarge: TextStyle(fontSize: bodyText, color: textGrey, height: 1.6),
        labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryGreen, letterSpacing: 2),
      ),
    ),
  );

  static var cardDark;
}