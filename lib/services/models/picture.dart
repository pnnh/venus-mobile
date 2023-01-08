import 'dart:io';

import 'package:dream/services/models/folder.dart';
import 'package:dream/utils/image.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';

part 'picture.g.dart';

@JsonSerializable()
class PictureModel {
  String pk;
  String file;

  PictureModel(this.pk, this.file);

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureModelToJson(this);
}

@JsonSerializable()
class PictureQueryResult {
  List<PictureModel> list = [];
  int count = 0;

  PictureQueryResult();

  factory PictureQueryResult.fromJson(Map<String, dynamic> json) =>
      _$PictureQueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$PictureQueryResultToJson(this);
}

Future<void> macosAccessingSecurityScopedResource(String bookmark) async {
  final secureBookmarks = SecureBookmarks();
  final resolvedFile = await secureBookmarks.resolveBookmark(bookmark);

  await secureBookmarks.startAccessingSecurityScopedResource(resolvedFile);
}

Future<List<PictureModel>> selectPics(String folderPath) async {
  debugPrint("selectPics: $folderPath");
  if (folderPath.trim().isEmpty) {
    return List.empty();
  }

  var realPath = folderPath;
  final dir = Directory(realPath);
  var fileList = dir.list(recursive: false, followLinks: false);
  List<PictureModel> files = <PictureModel>[];
  await for (FileSystemEntity entity in fileList) {
    FileSystemEntityType type = await FileSystemEntity.type(entity.path);
    if (type == FileSystemEntityType.file) {
      var isPic = isImage(entity.path);
      debugPrint("isPic: ${entity.path} $isPic");
      if (!isPic) continue;
      var picPk = generateRandomString(16);
      var pic = PictureModel(picPk, entity.path);
      files.add(pic);
    }
  }

  return files;
}
