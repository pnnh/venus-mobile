// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderModel _$FolderModelFromJson(Map<String, dynamic> json) => FolderModel(
      json['pk'] as String,
      title: json['title'] as String? ?? "",
      count: json['count'] as int? ?? 0,
      icon: json['icon'] as String? ?? "static/images/icons/folder.svg",
      path: json['path'] as String,
      bookmark: json['bookmark'] as String? ?? "",
    );

Map<String, dynamic> _$FolderModelToJson(FolderModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'count': instance.count,
      'icon': instance.icon,
      'path': instance.path,
      'bookmark': instance.bookmark,
    };
