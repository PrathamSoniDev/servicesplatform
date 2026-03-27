import 'package:flutter/material.dart';

class Responsive {
  // ===============================
  // BREAKPOINTS (IMPROVED)
  // ===============================

  static const double mobileMax = 600;
  static const double tabletMax = 1024;
  static const double desktopMax = 1440;

  // ===============================
  // DEVICE TYPE
  // ===============================

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMax &&
      MediaQuery.of(context).size.width < tabletMax;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  // ===============================
  // SIZE HELPERS
  // ===============================

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// % based width (VERY IMPORTANT 🔥)
  static double wp(BuildContext context, double percent) =>
      width(context) * percent;

  /// % based height
  static double hp(BuildContext context, double percent) =>
      height(context) * percent;

  // ===============================
  // CONTENT WIDTH CONTROL
  // ===============================

  static double maxContentWidth(BuildContext context) {
    double w = width(context);

    if (w > 1600) return 1400;
    if (w > 1200) return 1200;
    if (w > 900) return 900;

    return double.infinity;
  }

  /// CENTERED CONTAINER
  static Widget centered({
    required BuildContext context,
    required Widget child,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxContentWidth(context),
        ),
        child: child,
      ),
    );
  }

  // ===============================
  // PADDING (FLUID)
  // ===============================

  static double pagePadding(BuildContext context) {
    double w = width(context);

    if (w > 1400) return 120;
    if (w > 1000) return 80;
    if (w > 700) return 40;
    return 20;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: pagePadding(context),
      vertical: isMobile(context) ? 20 : 40,
    );
  }

  // ===============================
  // SPACING SYSTEM
  // ===============================

  static double sectionSpacing(BuildContext context) {
    double w = width(context);

    if (w > 1400) return 100;
    if (w > 1000) return 80;
    if (w > 700) return 60;
    return 40;
  }

  // ===============================
  // TEXT SCALING (FLUID 🔥)
  // ===============================

  static double scaleText(BuildContext context, double size) {
    double w = width(context);

    /// Fluid scaling (not jumpy)
    double scaleFactor = (w / 1440).clamp(0.8, 1.2);

    return size * scaleFactor;
  }

  // ===============================
  // GRID SYSTEM (SMART)
  // ===============================

  static int gridCount(BuildContext context) {
    double w = width(context);

    if (w > 1400) return 4;
    if (w > 1000) return 3;
    if (w > 700) return 2;
    return 1;
  }

  // ===============================
  // ADAPTIVE BUILDER
  // ===============================

  static Widget adaptive({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  // ===============================
  // FLEXIBLE CARD WIDTH (🔥 IMPORTANT)
  // ===============================

  static double cardWidth(BuildContext context) {
    double w = width(context);

    if (w > 1400) return 320;
    if (w > 1000) return 280;
    if (w > 700) return 240;

    return w * 0.8; // mobile scroll cards
  }
}