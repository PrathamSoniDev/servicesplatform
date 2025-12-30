import 'package:flutter/cupertino.dart';
import 'package:servicesplatform/network/dio_client.dart';

import '../../core/storage/cache_keys.dart';
import '../../core/storage/local_cache.dart';
import '../core/hero/hero_model.dart';

class HeroRepository {
  static const _cacheDuration = Duration(hours: 48);

  /// Fetch heroes with cache-first strategy
  Future<List<HeroModel>> getHeroes() async {
    // 1️⃣ Try cache
    final cached = await LocalCache.load(
      CacheKeys.heroBanners,
      maxAge: _cacheDuration,
    );

    if (cached != null) {
      debugPrint("Fetching the Hero Banners from the cache");
      debugPrint("Debugging the Cache Hero Banners $cached");
      return (cached as List).map((e) => HeroModel.fromJson(e)).toList();
    }

    // 2️⃣ Fetch from API
    final response = await DioClient.dio.get('/api/hero/');

    final List data = response.data;
    debugPrint("Debugging Hero Banners Data ${response.data}");
    // 3️⃣ Save cache
    await LocalCache.save(CacheKeys.heroBanners, data);

    return data.map((e) => HeroModel.fromJson(e)).toList();
  }

  /// Force refresh (admin / pull-to-refresh)
  Future<List<HeroModel>> refreshHeroes() async {
    await LocalCache.clear(CacheKeys.heroBanners);
    return getHeroes();
  }
}
