import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class PictureFolder {
  String pk;
  String title;
  int count;
  String icon;

  PictureFolder(this.pk,
      {this.title = "",
      this.count = 0,
      this.icon = "static/images/icons/folder.svg"});

  factory PictureFolder.fromJson(Map<String, dynamic> json) =>
      _$PictureFolderFromJson(json);

  Map<String, dynamic> toJson() => _$PictureFolderToJson(this);
}

Future<List<PictureFolder>> queryPictureFolders() {
  var list = <PictureFolder>[];
  list.add(PictureFolder("0",
      title: "主目录", count: 3258, icon: "static/images/icons/folder.svg"));
  list.add(PictureFolder("1",
      title: "下载", count: 19, icon: "static/images/icons/folder.svg"));
  list.add(PictureFolder("2",
      title: "图片", count: 2190, icon: "static/images/icons/folder.svg"));
  list.add(PictureFolder("3",
      title: "文档", count: 182, icon: "static/images/icons/folder.svg"));

  return Future(() => list);
}
