import 'package:flutter/material.dart';

import '../../services/hero_repository.dart';
import '../../services/theme_repository.dart';
import '../hero/hero_model.dart';
import '../theme/theme_model.dart';
import 'app_bootstrap_model.dart';

class AppBootstrapRepository {
  final ThemeRepository themeRepository;
  final HeroRepository heroRepository;

  AppBootstrapRepository({
    required this.themeRepository,
    required this.heroRepository,
  });

  Future<AppBootstrapModel> bootstrap() async {
    try {
      debugPrint('🚀 Bootstrapping application data');

      final results = await Future.wait([
        ThemeRepository.getTheme(),
        heroRepository.getHeroes(),
      ]);

      return AppBootstrapModel(
        theme: results[0] as ThemeResponse,
        heroes: results[1] as List<HeroModel>,
      );
    } catch (e, st) {
      debugPrint('❌ Bootstrap failed: $e\n$st');
      rethrow;
    }
  }
}
