import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

var databaseName = 'doggie_database.db';

class SqliteStore {
  static Future<Database> getDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var homeDir = appDocPath; //appHomeDirectory();
    var fullPath = join(homeDir, databaseName);
    debugPrint("fullPath: $fullPath");

    var db = openDatabase(
      fullPath,
      onCreate: (db, version) {
        var createDDL = """create table main.folders
(
    pk    TEXT primary key,
    title TEXT,
    path  TEXT,
    count integer,
    icon  text,
    bookmark text
);
""";
        return db.execute(
          createDDL,
        );
      },
      version: 1,
    );
    return db;
  }

  static Future<Map<String, dynamic>?> getByPk(String table, String pk) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps =
        await db.query(table, where: "pk=?", whereArgs: [pk]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(table);

    return maps;
  }

  static Future<void> insert(String table, Map<String, Object?> values) async {
    final db = await getDatabase();

    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
