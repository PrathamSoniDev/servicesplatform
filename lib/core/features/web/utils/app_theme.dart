import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF8E2DE2);
  static const Color secondary = Color(0xFF4A00E0);
  static const Color background = Colors.black;

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    useMaterial3: true,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
    ),

    textTheme: GoogleFonts.montserratTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
        ),
        headlineMedium: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
