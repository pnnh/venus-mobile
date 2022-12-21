import 'dart:convert';
import 'dart:io';

import 'package:dream/config.dart';
import 'package:dream/services/models/folder.dart';
import 'package:dream/utils/image.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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

Future<PictureQueryResult> queryPictures(String group) async {
  var url = Uri.parse('${AppConfig.serverUrl}/restful/resources/query');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "page": 1,
        "group": group,
        "query": "",
      }));
  if (kDebugMode) {
    print('Response status: ${response.statusCode}');
  }

  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  var count = decodedResponse['count'];
  Iterable list = decodedResponse['list'] as List;

  print('count: $count');
  var result = PictureQueryResult.fromJson(decodedResponse);
  return result;
}

Future<List<PictureModel>> selectPics(PictureFolder folder) async {
  debugPrint("selectPics: $folder");
  if (folder.path.trim().isEmpty) {
    return List.empty();
  }
  final secureBookmarks = SecureBookmarks();
  final resolvedFile = await secureBookmarks.resolveBookmark(folder.bookmark);
// resolved is now a File object, but before accessing it, call:
  await secureBookmarks.startAccessingSecurityScopedResource(resolvedFile);

  // var realPath = lookupPath(picDir);
  // debugPrint("realPath: $realPath");
  var realPath = folder.path;
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
 // await secureBookmarks.stopAccessingSecurityScopedResource(resolvedFile);
  return files;
}
