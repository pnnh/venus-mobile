import 'dart:io';

import 'package:dream/utils/path.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/folder.dart';

var databaseName = 'doggie_database.db';

class SqliteStore {
  static SqliteStore defaultStore = SqliteStore();

  late Future<Database> database;

  SqliteStore() {
    var homeDir = homeDirectory();
    var fullPath = "$homeDir/Documents/$databaseName";
    debugPrint("fullPath: $fullPath");

    var db = openDatabase(
      join(fullPath, databaseName),
      onCreate: (db, version) {
        var createDDL = """create table main.folders
(
    pk    TEXT primary key,
    title TEXT,
    path  TEXT,
    count integer,
    icon  text
);
""";
        return db.execute(
          createDDL,
        );
      },
      version: 1,
    );
    database = db;
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(table);

    return maps;
  }

  Future<void> insert(String table, Map<String, Object?> values) async {
    final db = await database;

    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
