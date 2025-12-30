import 'package:flutter/material.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';

import '../../features/web/presentation/home/hero_section.dart';
import 'hero_model.dart';

HeroContentAlignment _alignmentFromFlags(HeroModel hero) {
  if (hero.isContentRight) return HeroContentAlignment.right;
  if (hero.isContentCenter) return HeroContentAlignment.center;
  return HeroContentAlignment.left;
}

String? resolveAssetUrl(String? assetUrl) {
  if (assetUrl == null || assetUrl.isEmpty) return null;

  // Already absolute URL
  if (assetUrl.startsWith('http')) {
    return assetUrl;
  }

  // Ensure no double slash
  final normalized = assetUrl.startsWith('/') ? assetUrl : '/$assetUrl';

  final fullUrl = '${CacheKeys.apiBaseUrl}$normalized';

  debugPrint('Resolved Asset URL: $fullUrl');

  return fullUrl;
}

HeroSection buildHeroSection({
  required HeroModel hero,
  required String baseUrl,
  List<Widget>? buttons,
}) {
  return HeroSection(
    title: hero.headingText,
    subtitle: hero.subHeadingText,
    imagePath: resolveAssetUrl(hero.assetUrl),

    // Gradient line
    gradientText: hero.gradientText,
    showGradient: hero.gradientText != null,

    contentAlignment: _alignmentFromFlags(hero),

    customButtons: buttons,

    // Optional future extensions
    isOverlayMode: hero.isGif || hero.isVideo,
  );
}
