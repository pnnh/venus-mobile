import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class PictureFolder {
  String pk;
  String title;
  int count;
  String icon;
  String path;
  String bookmark = "";

  PictureFolder(this.pk,
      {this.title = "",
      this.count = 0,
      this.icon = "static/images/icons/folder.svg",
      required this.path,
      this.bookmark = ""});

  factory PictureFolder.fromJson(Map<String, dynamic> json) =>
      _$PictureFolderFromJson(json);

  Map<String, dynamic> toJson() => _$PictureFolderToJson(this);
}
