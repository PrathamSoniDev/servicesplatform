import 'package:flutter/material.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';
import 'package:servicesplatform/core/storage/sqlite_cache.dart';
import 'package:servicesplatform/models/category_model.dart';
import 'package:servicesplatform/models/design_item_models.dart';
import 'package:servicesplatform/models/design_list_response.dart';
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
      final categories = designRepository.fetchCategories();
      final heroFuture = heroRepository.getHeroes();
      final designFuture = designRepository.listDesigns();
      final blogFuture = blogRepository.listBlogs();
      // 🔹 Optional profile
      final category = await categories;
      final theme = await themeFuture;
      final heroes = await heroFuture;
      final designs = await designFuture;
      final blogs = await blogFuture;
      final profileFuture =
          accessToken != null ? authRepository.getUserProfile() : null;
      ProfileModel? profile;
      final Map<String, String> categoryMap = {
        for (final c in category) c.id.trim(): c.name,
      };

      if (profileFuture != null) {
        try {
          final rawProfile = await profileFuture;

          List<DesignItem> enrich(List<DesignItem> items) {
            return items
                .map(
                  (d) => d.copyWith(
                    categoryName: categoryMap[d.categoryId.trim()],
                  ),
                )
                .toList();
          }

          debugPrint(
            "🔹 Enriching profile designs with category names $categoryMap",
          );
          profile = rawProfile.copyWith(
            likedDesigns: enrich(rawProfile.likedDesigns),
            recentDesigns: enrich(rawProfile.recentDesigns),
            suggestDesigns: enrich(rawProfile.suggestDesigns),
            buyDesigns: enrich(rawProfile.buyDesigns),
          );
          debugPrint(
            "🔹 Raw Profile fetched: ${profile.recentDesigns.first.categoryName}",
          );
        } catch (e, st) {
          debugPrint('⚠️ Profile load failed: $e\n$st');
          profile = null;
        }
      }
      final Set<String> likedDesignIds =
          profile?.likedDesigns.map((e) => e.toString()).toSet() ?? <String>{};
      // final Set<String> likedDesignIds =
      //     profile?.likedDesigns.toSet() ?? <String>{};

      // 🔹 Enrich designs with categoryName
      final DesignListResponse enrichedDesigns = DesignListResponse(
        items:
            designs.items.map((design) {
              final bool isLiked = likedDesignIds.contains(design.id);
              return design.copyWith(
                categoryName: categoryMap[design.categoryId],
                isLiked: isLiked,
              );
            }).toList(),
        total: designs.total,
        page: designs.page,
        limit: designs.limit,
        totalPages: designs.totalPages,
      );

      debugPrint(
        "Final Enrich Designs are : ${enrichedDesigns.items[0].categoryName}",
      );
      debugPrint(
        "Profile Recent Designs : ${profile?.recentDesigns.first.categoryName}",
      );
      return AppBootstrapModel(
        category: category,
        theme: theme,
        heroes: heroes,
        profile: profile,
        designs: enrichedDesigns,
        blogs: blogs,
      );
    } catch (e, st) {
      debugPrint('❌ Bootstrap failed: $e\n$st');
      rethrow;
    }
  }

  Future<ProfileModel?> fetchUserProfile(List<CategoryModel> category) async {
    final String? accessToken = await SQLiteCache.load<String>(
      CacheKeys.accessToken,
      maxAge: const Duration(days: 365),
    );

    if (accessToken == null) return null;

    try {
      final ProfileModel rawProfile = await authRepository.getUserProfile();
      final Map<String, String> categoryMap = {
        for (final c in category) c.id.trim(): c.name,
      };
      List<DesignItem> enrich(List<DesignItem> items) {
        return items
            .map(
              (d) => d.copyWith(categoryName: categoryMap[d.categoryId.trim()]),
            )
            .toList();
      }

      debugPrint(
        "🔹 Enriching profile designs with category names $categoryMap",
      );
      return rawProfile.copyWith(
        likedDesigns: enrich(rawProfile.likedDesigns),
        recentDesigns: enrich(rawProfile.recentDesigns),
        suggestDesigns: enrich(rawProfile.suggestDesigns),
        buyDesigns: enrich(rawProfile.buyDesigns),
      );
    } catch (e) {
      debugPrint("⚠️ Profile fetch failed: $e");
      return null;
    }
  }
}
