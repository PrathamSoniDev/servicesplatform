import 'package:flutter/cupertino.dart';

import '../core/storage/sqlite_cache.dart';
import '../core/theme/theme_model.dart';
import '../network/dio_client.dart';

class ThemeRepository {
  static const _cacheDuration = Duration(hours: 48);

  static Future<ThemeResponse> getTheme() async {
    final cached = await SQLiteCache.load('theme_data', maxAge: _cacheDuration);

    if (cached != null) {
      debugPrint("🎨 Theme from SQLite cache");
      return ThemeResponse.fromJson(cached);
    }

    final res = await DioClient.dio.get('/api/theme/?mode=dark');
    await SQLiteCache.save('theme_data', res.data);

    return ThemeResponse.fromJson(res.data);
  }
}
