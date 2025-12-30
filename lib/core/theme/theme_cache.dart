import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCache {
  static const _keyData = 'theme_data';
  static const _keyTime = 'theme_cached_at';
  static const cacheDuration = Duration(hours: 48);

  static Future<void> save(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyData, jsonEncode(json));
    await prefs.setInt(_keyTime, DateTime.now().millisecondsSinceEpoch);
    debugPrint("Theme Cache Successfully");
  }

  static Future<Map<String, dynamic>?> get() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyData);
    final time = prefs.getInt(_keyTime);

    if (data == null || time == null) return null;

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(time);
    if (DateTime.now().difference(cachedAt) > cacheDuration) {
      return null; // expired
    }

    return jsonDecode(data);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyData);
    await prefs.remove(_keyTime);
  }
}
