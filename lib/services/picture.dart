import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:venus/utils/utils.dart';

import 'package:venus/utils/image.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

import 'database.dart';
import 'models/picture.dart';
import 'models/search.dart';

class PictureStore {

  static Future<List<PictureModel>> searchPictures(String a) async {
    var sqlText = '''select pk, header, body, 
    simple_highlight(searches, 3, '[', ']') as highlight 
    from searches where body match jieba_query('国');''';

    var list = DBHelper.globalDatabase.select(sqlText);

    debugPrint("list ${list.length}");

    var searchList = List.generate(list.length, (i) {
      return SearchModel.fromJson(list[i]);
    });

    return List.empty();
  }

  static void insertPictureIfNotExists(PictureModel model) {
    var sqlText = '''select pk from pictures where path = ?;''';

    var list = DBHelper.globalDatabase.select(sqlText, [model.path]);

    if (list.isNotEmpty) {
      return;
    }

    try {
      var sqlTextBegin = "begin;";
      var sqlTextInsertFolder = '''
insert into pictures(pk, path)
values(?, ?);
''';
      var sqlTextInsertSearches = '''
insert into searches(pk, header, body)
values(?, ?, ?);
''';
      var sqlTextCommit = "commit;";

      DBHelper.globalDatabase.execute(sqlTextBegin);
      DBHelper.globalDatabase
          .execute(sqlTextInsertFolder, [model.pk, model.path]);
      DBHelper.globalDatabase
          .execute(sqlTextInsertSearches, [model.pk, 'picture', basename(model.path)]);
      DBHelper.globalDatabase.execute(sqlTextCommit);
    } catch (e) {
      var sqlTextRollback = "rollback;";
      DBHelper.globalDatabase.execute(sqlTextRollback);
    }
  }


  static Future<bool> checkFileExists(String path) async {
    var sqlText = '''select pk from pictures where path = ?;''';

    var list = DBHelper.globalDatabase.select(sqlText, [path]);

    return list.isNotEmpty;
  }
}

class PictureBusiness {
  static Future<void> macosAccessingSecurityScopedResource(String bookmark) async {
    if (bookmark.isEmpty)
      return;
    final secureBookmarks = SecureBookmarks();
    final resolvedFile = await secureBookmarks.resolveBookmark(bookmark);

    await secureBookmarks.startAccessingSecurityScopedResource(resolvedFile);
  }

  static Future<List<PictureModel>> scanPictures(String folderPath) async {
    debugPrint("selectPics: $folderPath");
    if (folderPath.trim().isEmpty) {
      return List.empty();
    }

    var realPath = folderPath;
    final dir = Directory(realPath);
    var isDirExist = await dir.exists();
    if (!isDirExist) {
      return List.empty();
    }
    var fileList = dir.list(recursive: false, followLinks: false);
    List<PictureModel> files = <PictureModel>[];
    await for (FileSystemEntity entity in fileList) {
      FileSystemEntityType type = await FileSystemEntity.type(entity.path);
      if (type == FileSystemEntityType.file) {
        var isPic = isImage(entity.path);
        debugPrint("isPic: ${entity.path} $isPic");
        if (!isPic) continue;
        var picPk = generateRandomString(16);
        var model = PictureModel(picPk, entity.path);
        files.add(model);
        // 保存到数据库
        PictureStore.insertPictureIfNotExists(model);
      }
    }

    return files;
  }
}



