import '../core/theme/theme_model.dart';
import '../core/theme_cache.dart';
import '../network/dio_client.dart';

class ThemeRepository {
  static Future<ThemeResponse> getTheme() async {
    final cached = await ThemeCache.get();
    if (cached != null) {
      return ThemeResponse.fromJson(cached);
    }

    final res = await DioClient.dio.get('/api/theme/?mode=dark');
    await ThemeCache.save(res.data);

    return ThemeResponse.fromJson(res.data);
  }
}
