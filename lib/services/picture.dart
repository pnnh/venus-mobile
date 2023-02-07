import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:venus/services/models/folder.dart';
import 'package:venus/utils/utils.dart';

import 'package:venus/utils/image.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

import 'database.dart';
import 'folder.dart';
import 'models/picture.dart';
import 'models/search.dart';

Future<List<PictureModel>> searchPictures(String a) async {
  var sqlText = '''select pk, header, body, 
    simple_highlight(searches, 3, '[', ']') as highlight 
    from searches where body match jieba_query('国');''';

  var list = await DBHelper.instance.selectAsync(sqlText);

  debugPrint("list ${list.length}");

  var searchList = List.generate(list.length, (i) {
    return SearchModel.fromJson(list[i]);
  });

  return List.empty();
}

Future<List<PictureModel>> selectPicturesByFolder(String folderPk) async {
  if (folderPk.isEmpty) return List.empty();
  var sqlText = '''select p.*, f.path path from pictures p 
    left join folders f on p.folder = f.pk where folder = ?
    order by basename limit 100;''';

  var list = await DBHelper.instance.selectAsync(sqlText, [folderPk]);

  var pictureList = List.generate(list.length, (i) {
    return PictureModel.fromJson(list[i]);
  });

  return pictureList;
}

void insertPictureIfNotExists(PictureModel model, String folderPk) async {
  await DBHelper.instance.transactionAsync((database) {
    var sqlText = '''select pk from pictures where folder = ? and basename = ?;''';
    var list = database.select(sqlText, [folderPk, model.basename]);
    if (list.isNotEmpty) {
      return false;
    }

    // 插入图片数据
    var sqlTextInsertPicture = '''
insert into pictures(pk, basename, folder)
values(?, ?, ?);
''';
    database.execute(sqlTextInsertPicture, [model.pk, model.basename, folderPk]);

    // 插入索引数据
    var sqlTextInsertSearches = '''
insert into searches(pk, header, body)
values(?, ?, ?);
''';
    database.execute(
        sqlTextInsertSearches, [model.pk, 'picture', model.basename]);

    return true;
  });
}

Future<void> macosAccessingSecurityScopedResource(String bookmark) async {
  if (bookmark.isEmpty) return;
  final secureBookmarks = SecureBookmarks();
  final resolvedFile = await secureBookmarks.resolveBookmark(bookmark);

  await secureBookmarks.startAccessingSecurityScopedResource(resolvedFile);
}

Future<void> scanPicturesWorker(FolderModel folderModel) async {
  if (folderModel.path.trim().isEmpty || folderModel.pk.trim().isEmpty) {
    return;
  }
  if (Platform.isMacOS && folderModel.bookmark.isNotEmpty) {
    await macosAccessingSecurityScopedResource(folderModel.bookmark);
  }
  var realPath = folderModel.path;
  final dir = Directory(realPath);
  var isDirExist = await dir.exists();
  if (!isDirExist) {
    return;
  }
  var fileListStream = dir.list(recursive: false, followLinks: false);
  var filesCount = 0;
  await for (FileSystemEntity entity in fileListStream) {
    FileSystemEntityType type = await FileSystemEntity.type(entity.path);
    if (type == FileSystemEntityType.file) {
      var isPic = isImage(entity.path);

      if (!isPic) continue;
      filesCount += 1;
      var picPk = generateRandomString(16);
      var model = PictureModel(picPk, basename(entity.path), dirname(entity.path));
      // 保存到数据库
      insertPictureIfNotExists(model, folderModel.pk);
    }
  }
  await updateFilesCount(folderModel.pk, filesCount);
}
