import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

import '../utils/utils.dart';
import 'models/folder.dart';

class Folders {
  static Future<PictureFolder?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      debugPrint("selectedDirectory: $selectedDirectory");

      final secureBookmarks = SecureBookmarks();
      final bookmark = await secureBookmarks.bookmark(File(selectedDirectory));

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
