// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureFolder _$PictureFolderFromJson(Map<String, dynamic> json) =>
    PictureFolder(
      json['pk'] as String,
      title: json['title'] as String? ?? "",
      count: json['count'] as int? ?? 0,
      icon: json['icon'] as String? ?? "static/images/icons/folder.svg",
      path: json['path'] as String,
    );

Map<String, dynamic> _$PictureFolderToJson(PictureFolder instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'count': instance.count,
      'icon': instance.icon,
      'path': instance.path,
    };
