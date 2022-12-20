// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      pk: json['pk'] as String? ?? "",
      title: json['title'] as String? ?? "",
      uri: json['uri'] as String? ?? "",
      created: json['created'] as int? ?? 0,
    )
      ..description = json['description'] as String
      ..body = json['body'] as String
      ..createTime = DateTime.parse(json['create_time'] as String)
      ..updateTime = DateTime.parse(json['update_time'] as String)
      ..markLang = json['mark_lang'] as int
      ..markText = json['mark_text'] as String
      ..cover = json['cover'] as String
      ..keywordsList = (json['keywords_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      'create_time': instance.createTime.toIso8601String(),
      'update_time': instance.updateTime.toIso8601String(),
      'uri': instance.uri,
      'mark_lang': instance.markLang,
      'mark_text': instance.markText,
      'created': instance.created,
      'cover': instance.cover,
      'keywords_list': instance.keywordsList,
    };

ArticleFindResult _$ArticleFindResultFromJson(Map<String, dynamic> json) =>
    ArticleFindResult(
      data: json['data'] == null
          ? null
          : ArticleModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleFindResultToJson(ArticleFindResult instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
