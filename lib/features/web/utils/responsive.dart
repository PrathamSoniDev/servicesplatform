import 'package:flutter/material.dart';

class Responsive {

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double pagePadding(BuildContext context) {

    if (isDesktop(context)) {
      return 120;
    }

    if (isTablet(context)) {
      return 60;
    }

    return 24;
  }
}