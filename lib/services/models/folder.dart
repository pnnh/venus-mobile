import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class FolderModel {
  String pk;
  String path;
  String bookmark = "";
  int count = 0;

  FolderModel(this.pk,
      {
      required this.path,
      this.bookmark = ""});

  factory FolderModel.fromJson(Map<String, dynamic> json) =>
      _$FolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$FolderModelToJson(this);
}
