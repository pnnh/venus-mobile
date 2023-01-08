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
  final Map<String, dynamic>? data = await getByPk('folders', pk);

  if (data != null) {
    return PictureFolder.fromJson(data);
  }
  return null;
}

Future<List<PictureFolder>> selectFolders(String path) async {
  final List<Map<String, dynamic>> maps = await query('folders');

  return List.generate(maps.length, (i) {
    return PictureFolder.fromJson(maps[i]);
  });
}

Future<void> insertFolder(PictureFolder dog) async {
  await insert(
    'folders',
    dog.toJson(),
  );
}
