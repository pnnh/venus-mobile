import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class PictureFolder {
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

Future<List<PictureFolder>> queryPictureFolders() {
  var list = <PictureFolder>[];
  list.add(PictureFolder("0",
      title: "主目录",
      count: 3258,
      icon: "static/images/icons/folder.svg",
      path: "~"));
  list.add(PictureFolder("1",
      title: "下载",
      count: 19,
      icon: "static/images/icons/folder.svg",
      path: "~/Downloads"));
  list.add(PictureFolder("2",
      title: "图片",
      count: 2190,
      icon: "static/images/icons/folder.svg",
      path: "~/Pictures"));
  list.add(PictureFolder("3",
      title: "文档",
      count: 182,
      icon: "static/images/icons/folder.svg",
      path: "~/Documents"));

  return Future(() => list);
}
