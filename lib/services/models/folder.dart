import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class FolderModel {
  String pk;
  String title;
  int count;
  String icon;
  String path;
  String bookmark = "";

  FolderModel(this.pk,
      {this.title = "",
      this.count = 0,
      this.icon = "static/images/icons/folder.svg",
      required this.path,
      this.bookmark = ""});

  factory FolderModel.fromJson(Map<String, dynamic> json) =>
      _$FolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$FolderModelToJson(this);
}
