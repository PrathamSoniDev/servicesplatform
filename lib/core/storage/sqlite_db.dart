import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLiteDB {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final path = join(await getDatabasesPath(), 'app_cache.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE cache (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL,
            cached_at INTEGER NOT NULL
          )
        ''');
      },
    );

    return _db!;
  }
}
