import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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

var defaultFolders = <PictureFolder>[];

Future<List<PictureFolder>> queryPictureFolders() {
  var list = <PictureFolder>[];
  // list.add(PictureFolder("0",
  //     title: "主目录",
  //     count: 3258,
  //     icon: "static/images/icons/folder.svg",
  //     path: "/Users/Larry"));
  // list.add(PictureFolder("1",
  //     title: "下载",
  //     count: 19,
  //     icon: "static/images/icons/folder.svg",
  //     path: "/Users/Larry/Downloads"));
  // list.add(PictureFolder("2",
  //     title: "图片",
  //     count: 2190,
  //     icon: "static/images/icons/folder.svg",
  //     path: "/Users/Larry/Pictures"));
  // list.add(PictureFolder("3",
  //     title: "文档",
  //     count: 182,
  //     icon: "static/images/icons/folder.svg",
  //     path: "/Users/Larry/Documents"));

  return Future(() => list);
}

void addFolder(PictureFolder folder) {
  defaultFolders.add(folder);
  return;
}

Future<PictureFolder?> selectFolder() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    // User canceled the picker
    debugPrint("selectedDirectory: $selectedDirectory");
    var newFolder = PictureFolder("3",
        title: "文档",
        count: 182,
        icon: "static/images/icons/folder.svg",
        path: "/Users/Larry/Documents");
    //addFolder(newFolder);

    return newFolder;
  }

  return null;
}
