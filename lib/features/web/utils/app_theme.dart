import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ════════════════════════════════════════════════════════════════════════════
  //  BRAND COLORS  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color primary      = primaryGreen;

  // ════════════════════════════════════════════════════════════════════════════
  //  DARK THEME BASE  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const Color darkBackground   = Color(0xFF000000);
  static const Color surfaceGrey      = Color(0xFF121212);
  static const Color cardColor        = Color(0xFF161616);
  static const Color borderColor      = Color(0xFF262626);
  static const Color darkCard         = Color(0xFF1A1A1A);
  static const Color glassOverlayDark = Color(0xB3000000);

  // ════════════════════════════════════════════════════════════════════════════
  //  LIGHT THEME BASE  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const Color bgOffWhite  = Color(0xFFF8F9FB);
  static const Color cardLight   = Colors.white;
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color bgSoftGrey  = Color(0xFFF7F8FA);

  // ════════════════════════════════════════════════════════════════════════════
  //  TEXT COLORS  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const Color textBlack     = Color(0xFF1D1D1F);
  static const Color textGrey      = Color(0xFF6E6E73);
  static const Color textPrimary   = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);

  static const Color textWhite60 = Colors.white60;
  static const Color textWhite70 = Colors.white70;
  static const Color textWhite54 = Colors.white54;
  static const Color textWhite38 = Colors.white38;

  // ════════════════════════════════════════════════════════════════════════════
  //  UI COLORS  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const Color accentGreen = primaryGreen;
  static const Color white10     = Colors.white10;
  static const Color white24     = Colors.white24;
  static const Color black45     = Colors.black45;
  static const Color neonGreen   = Color(0xFF00FFA3);

  // ════════════════════════════════════════════════════════════════════════════
  //  CONTACT SCREEN COLORS  (new — "Monochrome Apex" palette)
  //
  //  Usage reference:
  //    contactBg          → Scaffold background  (pure black)
  //    contactCard        → Main frosted card fill
  //    contactBorder      → Default card / input borders
  //    contactBorderHi    → Highlighted / hovered borders
  //    contactWhite       → Pure white (button fill on hover, cursor)
  //    contactTextPri     → Primary text (headings, input text)
  //    contactTextSec     → Secondary / muted text (labels, subtitles)
  //    contactTextTer     → Tertiary / ghost text (input hints)
  //    contactInputBg     → Input field background
  //    contactInputBorder → Input field idle border
  //    contactShimmer     → Top card shimmer gradient centre stop
  //    contactDotGrid     → Dot-grid background dot colour
  //    contactRadarSweep  → Radar sweep line colour  (8 % white)
  //    contactRadarRing   → Radar concentric ring base colour (3 % white)
  // ════════════════════════════════════════════════════════════════════════════

  /// Pure black page background
  static const Color contactBg          = Color(0xFF000000);

  /// Near-black card surface
  static const Color contactCard        = Color(0xFF0D0D0D);

  /// Subtle card / divider border
  static const Color contactBorder      = Color(0xFF222222);

  /// Brighter border used on hover / focus states
  static const Color contactBorderHi    = Color(0xFF444444);

  /// Pure white — used for hover fills and cursor
  static const Color contactWhite       = Color(0xFFFFFFFF);

  /// Near-white primary text
  static const Color contactTextPri     = Color(0xFFF0F0F0);

  /// Mid-grey secondary / label text
  static const Color contactTextSec     = Color(0xFF666666);

  /// Dark-grey ghost / hint text inside inputs
  static const Color contactTextTer     = Color(0xFF3A3A3A);

  /// Very dark input field fill
  static const Color contactInputBg     = Color(0xFF111111);

  /// Input idle border
  static const Color contactInputBorder = Color(0xFF2A2A2A);

  /// Shimmer gradient white centre stop (card top line)
  static const Color contactShimmer     = Color(0xFFFFFFFF);

  /// Dot-grid background dot colour
  static const Color contactDotGrid     = Color(0xFF1C1C1C);

  /// Radar sweep line (8 % white)
  static const Color contactRadarSweep  = Color(0x14FFFFFF);

  /// Radar ring base (used with dynamic opacity)
  static const Color contactRadarRing   = Color(0x08FFFFFF);

  /// Footer link text
  static const Color contactFooterLink  = Color(0xFF555555);

  /// Watermark text (very subtle)
  static const Color contactWatermark   = Color(0xFFF0F0F0);

  // ════════════════════════════════════════════════════════════════════════════
  //  DYNAMIC HELPERS  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static Color getTextPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? textPrimary : textBlack;

  static Color getTextSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? textSecondary : textGrey;

  static Color getCardColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : cardLight;

  static Color getBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? borderColor : borderLight;

  // ════════════════════════════════════════════════════════════════════════════
  //  SPACING  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const double pagePaddingDesktop = 120;
  static const double pagePaddingTablet  = 60;
  static const double pagePaddingMobile  = 24;

  // ════════════════════════════════════════════════════════════════════════════
  //  TEXT SIZES  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

  static const double heroTitle    = 64;
  static const double sectionTitle = 42;
  static const double cardTitle    = 22;
  static const double bodyText     = 18;

  // ════════════════════════════════════════════════════════════════════════════
  //  DARK THEME  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

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
        headlineLarge: TextStyle(
          fontSize: heroTitle,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: sectionTitle,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: cardTitle,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyText,
          color: textSecondary,
          height: 1.6,
        ),
      ),
    ),
  );

  // ════════════════════════════════════════════════════════════════════════════
  //  LIGHT THEME  (original — preserved)
  // ════════════════════════════════════════════════════════════════════════════

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
        displayLarge: TextStyle(
          fontSize: heroTitle,
          fontWeight: FontWeight.w900,
          color: textBlack,
          letterSpacing: -2,
        ),
        displayMedium: TextStyle(
          fontSize: sectionTitle,
          fontWeight: FontWeight.bold,
          color: textBlack,
        ),
        titleLarge: TextStyle(
          fontSize: cardTitle,
          fontWeight: FontWeight.bold,
          color: textBlack,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyText,
          color: textGrey,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: primaryGreen,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}