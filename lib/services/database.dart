import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quantum/database/database.dart';

const databaseName = 'venus_database.db';

DataStore? _dataStore;

const foldersCreateDDL = """create table main.folders
(
    pk    TEXT primary key,
    title TEXT,
    path  TEXT,
    count integer,
    icon  text,
    bookmark text
);
""";

const fullTextSearchCreateDDL = """create virtual table main.searches
using fts5(
    pk unindexed,
    type unindexed,
    title,
    body
);
""";

Future<DataStore> _getDataStore() async {
  if (_dataStore != null) return _dataStore!;

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  var homeDir = appDocPath;
  var fullPath = join(homeDir, databaseName);
  debugPrint("fullPath: $fullPath");

  var ds = DataStore(
    fullPath,
    onCreate: (db, version) {
      db.execute(foldersCreateDDL);
      db.execute(fullTextSearchCreateDDL);
    },
    version: 1,
  );

  _dataStore = ds;
  return ds;
}

Future<Map<String, dynamic>?> getByPk(String table, String pk) async {
  final db = await _getDataStore();

  final List<Map<String, dynamic>> maps =
      await db.query(table, where: "pk=?", whereArgs: [pk]);
  if (maps.isNotEmpty) {
    return maps.first;
  }
  return null;
}

Future<List<Map<String, dynamic>>> query(String table) async {
  final db = await _getDataStore();

  final List<Map<String, dynamic>> maps = await db.query(table);

  return maps;
}

Future<void> insert(String table, Map<String, Object?> values) async {
  final db = await _getDataStore();

  await db.insert(
    table,
    values,
  );
}
