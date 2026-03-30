import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';

class SeoWrapper extends StatelessWidget {
  final Widget child;

  const SeoWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      child: child,
    );
  }
}