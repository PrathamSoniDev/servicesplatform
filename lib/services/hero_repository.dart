import 'package:flutter/material.dart';

import '../core/hero/hero_model.dart';
import '../core/storage/cache_keys.dart';
import '../core/storage/sqlite_cache.dart';
import '../network/dio_client.dart';

class HeroRepository {
  static const _cacheDuration = Duration(hours: 48);

  Future<List<HeroModel>> getHeroes() async {
    final cached = await SQLiteCache.load(
      CacheKeys.heroBanners,
      maxAge: _cacheDuration,
    );

    if (cached != null) {
      debugPrint("⚡ Heroes from SQLite cache");
      return (cached as List).map((e) => HeroModel.fromJson(e)).toList();
    } else {
      final response = await DioClient.dio.get('/api/hero/');
      final List data = response.data;

      await SQLiteCache.save(CacheKeys.heroBanners, data);

      return data.map((e) => HeroModel.fromJson(e)).toList();
    }
  }

  Future<List<HeroModel>> refreshHeroes() async {
    await SQLiteCache.clear(CacheKeys.heroBanners);
    return getHeroes();
  }
}
