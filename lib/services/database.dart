import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quantum_sqlite/quantum_sqlite.dart';
import 'package:sqlite3/sqlite3.dart';

const databaseName = 'venus_database.db';

class DBHelper {
  static late Database globalDatabase;

  static Future<void> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var homeDir = appDocPath;
    var fullPath = join(homeDir, databaseName);
    debugPrint("fullPath: $fullPath");

    var initSql = await rootBundle.loadString('static/sql/init.sql');

    final db = sqlite3.open(fullPath);

    db.loadSimpleExtension();

    if (initSql.isNotEmpty) {
      var list = initSql.split(";");
      for (var sqlText in list) {
        if (sqlText.trim().isEmpty) {
          continue;
        }
        db.execute(sqlText);
      }
    }

    globalDatabase = db;
  }
}

// Future<Map<String, dynamic>?> getByPk(String table, String pk) async {
//   final db = await _getDataStore();
//
//   final List<Map<String, dynamic>> maps =
//       await db.select(table, [pk]);
//   if (maps.isNotEmpty) {
//     return maps.first;
//   }
//   return null;
// }

// Future<List<Map<String, dynamic>>> query(String table) async {
//   final db = await _getDataStore();
//
//   final List<Map<String, dynamic>> maps = await db.query(table);
//
//   return maps;
// }
//
// Future<void> insert(String table, Map<String, Object?> values) async {
//   final db = await _getDataStore();
//
//   await db.insert(
//     table,
//     values,
//   );
// }
