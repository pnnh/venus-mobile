import 'package:dream/services/sqlite.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';
 

@JsonSerializable() 
class PictureFolder  { 
  String pk;
  String title;
  int count;
  String icon;
  String path;

  PictureFolder(this.pk,
      {this.title = "",
      this.count = 0,
      this.icon = "static/images/icons/folder.svg",
      required this.path});

  factory PictureFolder.fromJson(Map<String, dynamic> json) =>
      _$PictureFolderFromJson(json);

  Map<String, dynamic> toJson() => _$PictureFolderToJson(this);
}
 
Future<List<PictureFolder>> selectFolders(String path) async {
  final List<Map<String, dynamic>> maps =
      await SqliteStore.defaultStore.query('folders');

  return List.generate(maps.length, (i) {
    return PictureFolder.fromJson(maps[i]);
  });
}

Future<void> insertFolder(PictureFolder dog) async {
  await SqliteStore.defaultStore.insert(
    'folders',
    dog.toJson(),
  );
}
