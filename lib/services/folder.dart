import 'dart:io';
import 'dart:io' show Platform;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

import '../utils/utils.dart';
import 'database.dart';
import 'models/folder.dart';

void addFolder(String title, String path, String icon) {
  try {
    var sqlTextBegin = "begin;";
    var sqlTextInsertFolder = '''
insert into folders(pk, title, path, count, icon, bookmark)
values(?, ?, ?, 0, ?, '');
''';
    var sqlTextInsertSearches = '''
insert into searches(pk, header, body)
values(?, ?, ?);
''';
    var sqlTextCommit = "commit;";
    var pk = generateRandomString(8);

    DBHelper.globalDatabase.execute(sqlTextBegin);
    DBHelper.globalDatabase
        .execute(sqlTextInsertFolder, [pk, title, path, icon]);
    DBHelper.globalDatabase
        .execute(sqlTextInsertSearches, [pk, 'folder', title]);
    DBHelper.globalDatabase.execute(sqlTextCommit);
  } catch (e) {
    debugPrint("insertFolder: $e");
    var sqlTextRollback = "rollback;";
    DBHelper.globalDatabase.execute(sqlTextRollback);
  }
}

class Folders {
  static Future<PictureFolder?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      debugPrint("selectedDirectory: $selectedDirectory");

      String bookmark = "";
      if (Platform.isMacOS) {
        final secureBookmarks = SecureBookmarks();
        bookmark = await secureBookmarks.bookmark(File(selectedDirectory));
      }

      var pk = generateRandomString(16);
      var newFolder = PictureFolder(pk,
          title: basename(selectedDirectory),
          count: 182,
          icon: "static/images/icons/folder.svg",
          path: selectedDirectory,
          bookmark: bookmark);
      await insertFolder(newFolder);

      return newFolder;
    }

    return null;
  }
}

Future<PictureFolder?> getFolder(String pk) async {
  var sqlText = "select * from folders where pk = ?";

  //var resultSet = db.select(sqlText, [pk]);

  // if (resultSet.rows.isNotEmpty) {
  //   return resultSet.rows.first;
  // }
  return null;

  // final Map<String, dynamic>? data = await getByPk('folders', pk);
  //
  // if (data != null) {
  //   return PictureFolder.fromJson(data);
  // }
  // return null;
}

Future<void> insertFolder(PictureFolder dog) async {
  // await insert(
  //   'folders',
  //   dog.toJson(),
  // );
}
