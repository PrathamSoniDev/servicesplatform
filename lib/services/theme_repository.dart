import 'package:flutter/cupertino.dart';

import '../core/theme/theme_cache.dart';
import '../core/theme/theme_model.dart';
import '../network/dio_client.dart';

class ThemeRepository {
  static Future<ThemeResponse> getTheme() async {
    final cached = await ThemeCache.get();
    if (cached != null) {
      debugPrint("Fetching Theme from cache");
      return ThemeResponse.fromJson(cached);
    }
    debugPrint("Fetching Theme from api ");
    final res = await DioClient.dio.get('/api/theme/?mode=dark');
    await ThemeCache.save(res.data);

    return ThemeResponse.fromJson(res.data);
  }
}
