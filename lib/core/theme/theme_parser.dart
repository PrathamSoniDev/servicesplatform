import 'dart:math' as math;

import 'package:flutter/material.dart';

class ThemeParser {
  ThemeParser._();

  /* -------------------- COLOR TOKEN -------------------- */

  static Color parseColorToken(Map<String, dynamic>? token) {
    if (token == null) return Colors.transparent;

    try {
      // Solid
      if (token['type'] == 'solid' && token['value'] != null) {
        return _hex(token['value'] as String);
      }

      // Gradient fallback → first color
      final colors = token['colors'];
      if (colors is List && colors.isNotEmpty) {
        return _hex(colors.first as String);
      }
    } catch (_) {}

    return Colors.transparent;
  }

  /* -------------------- GRADIENT TOKEN -------------------- */

  static Gradient? parseGradientToken(Map<String, dynamic>? token) {
    if (token == null) return null;

    final rawColors = token['colors'];
    if (rawColors is! List || rawColors.length < 2) return null;

    final colors = rawColors
        .whereType<String>()
        .map(_hex)
        .toList(growable: false);

    final stops =
        (token['stops'] is List)
            ? (token['stops'] as List)
                .whereType<num>()
                .map((e) => e.toDouble())
                .toList()
            : null;

    final angle = token['angle'];

    switch (token['type']) {
      case 'linear':
        return LinearGradient(
          colors: colors,
          stops: stops,
          begin: _begin(angle),
          end: _end(angle),
        );

      case 'radial':
        return RadialGradient(
          colors: colors,
          stops: stops,
          center: Alignment.center,
          radius: 0.8,
        );
    }

    return null;
  }

  /* -------------------- HELPERS -------------------- */

  static Color _hex(String hex) => Color(int.parse(hex));

  static Alignment _begin(dynamic angle) {
    final r = _rad(angle);
    return Alignment(-math.cos(r), -math.sin(r));
  }

  static Alignment _end(dynamic angle) {
    final r = _rad(angle);
    return Alignment(math.cos(r), math.sin(r));
  }

  static double _rad(dynamic angle) => angle is num ? angle * math.pi / 180 : 0;
}
