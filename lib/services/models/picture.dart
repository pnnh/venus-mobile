import 'dart:io';

import 'package:venus/utils/image.dart';
import 'package:venus/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';

part 'picture.g.dart';

@JsonSerializable()
class PictureModel {
  String pk;
  String basename;
  String path;

  PictureModel(this.pk, this.basename, this.path);

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureModelToJson(this);

  get fullPath {
    return join(path, basename);
  }
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
