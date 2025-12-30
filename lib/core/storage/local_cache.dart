import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  static const _timeSuffix = '_cached_at';

  /// Save data with timestamp
  static Future<void> save(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, jsonEncode(data));
    await prefs.setInt(
      '$key$_timeSuffix',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Load cached data (null if expired or missing)
  static Future<dynamic> load(String key, {required Duration maxAge}) async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(key);
    final cachedAt = prefs.getInt('$key$_timeSuffix');

    if (raw == null || cachedAt == null) return null;

    final age = DateTime.now().millisecondsSinceEpoch - cachedAt;

    if (age > maxAge.inMilliseconds) {
      await clear(key);
      return null;
    }

    return jsonDecode(raw);
  }

  /// Clear specific cache
  static Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.remove('$key$_timeSuffix');
  }

  /// Clear all cache (useful for logout / debug)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
