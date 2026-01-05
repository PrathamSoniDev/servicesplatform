import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlite_db.dart';

class SQLiteCache {
  // =========================
  // PUBLIC API (UNCHANGED)
  // =========================

  static Future<void> save(String key, dynamic data) async {
    if (kIsWeb) {
      await _saveWeb(key, data);
    } else {
      await _saveDb(key, data);
    }
  }

  static Future<T?> load<T>(String key, {required Duration maxAge}) async {
    if (kIsWeb) {
      return _loadWeb<T>(key, maxAge);
    } else {
      return _loadDb<T>(key, maxAge);
    }
  }

  static Future<void> clear(String key) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      await prefs.remove('${key}_cached_at');
    } else {
      final db = await SQLiteDB.instance;
      await db.delete('cache', where: 'key = ?', whereArgs: [key]);
    }
  }

  static Future<void> clearAll() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } else {
      final db = await SQLiteDB.instance;
      await db.delete('cache');
    }
  }

  // =========================
  // WEB IMPLEMENTATION
  // =========================

  static Future<void> _saveWeb(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, jsonEncode(data));
    await prefs.setInt(
      '${key}_cached_at',
      DateTime.now().millisecondsSinceEpoch,
    );

    debugPrint("🗄️ [WEB] Cached [$key]");
  }

  static Future<T?> _loadWeb<T>(String key, Duration maxAge) async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(key);
    final cachedAt = prefs.getInt('${key}_cached_at');

    if (value == null || cachedAt == null) {
      debugPrint("⚠️ [WEB] Cache miss [$key]");
      return null;
    }

    final ageMs = DateTime.now().millisecondsSinceEpoch - cachedAt;

    if (ageMs > maxAge.inMilliseconds) {
      debugPrint("⏰ [WEB] Cache expired [$key]");
      await clear(key);
      return null;
    }

    try {
      return jsonDecode(value) as T;
    } catch (e) {
      debugPrint("❌ [WEB] Cache decode failed [$key]: $e");
      return null;
    }
  }

  // =========================
  // SQLITE IMPLEMENTATION
  // =========================

  static Future<void> _saveDb(String key, dynamic data) async {
    final db = await SQLiteDB.instance;

    await db.insert('cache', {
      'key': key,
      'value': jsonEncode(data),
      'cached_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    debugPrint("🗄️ [DB] Cached [$key]");
  }

  static Future<T?> _loadDb<T>(String key, Duration maxAge) async {
    final db = await SQLiteDB.instance;

    final res = await db.query(
      'cache',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (res.isEmpty) {
      debugPrint("⚠️ [DB] Cache miss [$key]");
      return null;
    }

    final cachedAt = res.first['cached_at'] as int;
    final ageMs = DateTime.now().millisecondsSinceEpoch - cachedAt;

    if (ageMs > maxAge.inMilliseconds) {
      debugPrint("⏰ [DB] Cache expired [$key]");
      await clear(key);
      return null;
    }

    try {
      return jsonDecode(res.first['value'] as String) as T;
    } catch (e) {
      debugPrint("❌ [DB] Cache decode failed [$key]: $e");
      return null;
    }
  }
}
