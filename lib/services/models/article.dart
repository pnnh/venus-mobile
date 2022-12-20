import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class ArticleModel {
  String pk = "";
  String title = "";
  String description = "";
  String body = "";
  @JsonKey(name: 'create_time')
  DateTime createTime = DateTime.utc(0);
  @JsonKey(name: 'update_time')
  DateTime updateTime = DateTime.utc(0);
  String uri = "";
  @JsonKey(name: 'mark_lang')
  int markLang = 0;
  @JsonKey(name: 'mark_text')
  String markText = "";
  int created = 0;
  String cover = "";
  @JsonKey(name: 'keywords_list')
  List<String> keywordsList = <String>[];

  ArticleModel(
      {this.pk = "", this.title = "", this.uri = "", this.created = 0});

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Map<String, dynamic> bodyJson() => jsonDecode(body);
}

@JsonSerializable()
class ArticleFindResult {
  ArticleModel? data;

  ArticleFindResult({this.data});

  factory ArticleFindResult.fromJson(Map<String, dynamic> json) =>
      _$ArticleFindResultFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleFindResultToJson(this);
}
