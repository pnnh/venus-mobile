import 'dart:io';
import 'dart:io' show Platform;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

import '../utils/utils.dart';
import 'database.dart';
import 'models/folder.dart';


class Folders {
  static Future<FolderModel?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      debugPrint("selectedDirectory: $selectedDirectory");

      String bookmark = "";
      if (Platform.isMacOS) {
        final secureBookmarks = SecureBookmarks();
        bookmark = await secureBookmarks.bookmark(File(selectedDirectory));
      }

      var pk = generateRandomString(16);
      var newFolder = FolderModel(pk,
          path: selectedDirectory,
          bookmark: bookmark);
      await insertFolder(newFolder);

      return newFolder;
    }

    return null;
  }
}

Future<FolderModel?> getFolder(String pk) async {
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

Future<void> updateFilesCount(String pk, int count) async {
  var sqlText = '''update folders set count = ? where pk = ?;''';

  await DBHelper().executeAsync(sqlText, [count, pk]);
}

Future<void> insertFolder(FolderModel model) async {
  await DBHelper.instance.transactionAsync((database)
  {
      var sqlTextInsertFolder = '''
insert into folders(pk, path, bookmark, count)
values(?, ?, ?, 0);
''';
      var pk = generateRandomString(8);

      database.execute(sqlTextInsertFolder, [pk, model.path, model.bookmark]);
      return true;
  });
}

Future<List<FolderModel>> queryFolders(String a) async {
  var sqlText = '''select * from folders;''';

  var list = await DBHelper().selectAsync(sqlText);

  debugPrint("list ${list.length}");

  var foldersList = List.generate(list.length, (i) {
    return FolderModel.fromJson(list[i]);
  });

  return foldersList;
}
