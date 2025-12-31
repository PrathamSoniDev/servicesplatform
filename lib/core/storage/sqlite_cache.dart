import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'sqlite_db.dart';

class SQLiteCache {
  static Future<void> save(String key, dynamic data) async {
    final db = await SQLiteDB.instance;

    await db.insert('cache', {
      'key': key,
      'value': jsonEncode(data),
      'cached_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    debugPrint("🗄️ Cached [$key]");
  }

  static Future<dynamic> load(String key, {required Duration maxAge}) async {
    final db = await SQLiteDB.instance;

    final res = await db.query(
      'cache',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (res.isEmpty) return null;

    final cachedAt = res.first['cached_at'] as int;
    final age = DateTime.now().millisecondsSinceEpoch - cachedAt;

    if (age > maxAge.inMilliseconds) {
      await clear(key);
      return null;
    }

    return jsonDecode(res.first['value'] as String);
  }

  static Future<void> clear(String key) async {
    final db = await SQLiteDB.instance;
    await db.delete('cache', where: 'key = ?', whereArgs: [key]);
  }

  static Future<void> clearAll() async {
    final db = await SQLiteDB.instance;
    await db.delete('cache');
  }
}
