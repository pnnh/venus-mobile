// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureModel _$PictureModelFromJson(Map<String, dynamic> json) =>
    PictureModel()..file = json['file'] as String;

Map<String, dynamic> _$PictureModelToJson(PictureModel instance) =>
    <String, dynamic>{
      'file': instance.file,
    };

PictureQueryResult _$PictureQueryResultFromJson(Map<String, dynamic> json) =>
    PictureQueryResult()
      ..list = (json['list'] as List<dynamic>)
          .map((e) => PictureModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..count = json['count'] as int;

Map<String, dynamic> _$PictureQueryResultToJson(PictureQueryResult instance) =>
    <String, dynamic>{
      'list': instance.list,
      'count': instance.count,
    };
