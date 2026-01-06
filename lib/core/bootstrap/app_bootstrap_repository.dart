import 'package:flutter/material.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';
import 'package:servicesplatform/core/storage/sqlite_cache.dart';
import 'package:servicesplatform/models/profile_model.dart';
import 'package:servicesplatform/services/auth_repository.dart';
import 'package:servicesplatform/services/blog_repository.dart';
import 'package:servicesplatform/services/design_repository.dart';

import '../../services/hero_repository.dart';
import '../../services/theme_repository.dart';
import 'app_bootstrap_model.dart';

class AppBootstrapRepository {
  final ThemeRepository themeRepository;
  final HeroRepository heroRepository;
  final AuthRepository authRepository;
  final BlogRepository blogRepository;
  final DesignRepository designRepository;
  AppBootstrapRepository({
    required this.themeRepository,
    required this.heroRepository,
    required this.authRepository,
    required this.blogRepository,
    required this.designRepository,
  });

  Future<AppBootstrapModel> bootstrap() async {
    try {
      debugPrint('🚀 Bootstrapping application data');

      final String? accessToken = await SQLiteCache.load<String>(
        CacheKeys.accessToken,
        maxAge: const Duration(days: 365),
      );

      debugPrint(
        "🔑 Access Token: ${accessToken != null ? 'FOUND' : 'NOT FOUND'}",
      );

      // 🔹 Public data (always required)
      final themeFuture = ThemeRepository.getTheme();
      final heroFuture = heroRepository.getHeroes();
      final designFuture = designRepository.listDesigns();
      final blogFuture = blogRepository.listBlogs();
      // 🔹 Optional profile
      final profileFuture =
          accessToken != null ? authRepository.getUserProfile() : null;

      final theme = await themeFuture;
      final heroes = await heroFuture;
      final designs = await designFuture;
      final blogs = await blogFuture;
      ProfileModel? profile;
      if (profileFuture != null) {
        try {
          profile = await profileFuture;
        } catch (e) {
          debugPrint("⚠️ Failed to load profile, continuing unauthenticated");
          profile = null;
        }
      }

      return AppBootstrapModel(
        theme: theme,
        heroes: heroes,
        profile: profile,
        designs: designs,
        blogs: blogs,
      );
    } catch (e, st) {
      debugPrint('❌ Bootstrap failed: $e\n$st');
      rethrow;
    }
  }

  Future<ProfileModel?> fetchUserProfile() async {
    final String? accessToken = await SQLiteCache.load<String>(
      CacheKeys.accessToken,
      maxAge: const Duration(days: 365),
    );

    if (accessToken == null) return null;

    try {
      return await authRepository.getUserProfile();
    } catch (e) {
      debugPrint("⚠️ Profile fetch failed: $e");
      return null;
    }
  }
}
