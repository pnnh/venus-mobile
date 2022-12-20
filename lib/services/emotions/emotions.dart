import 'dart:convert';
 
import 'package:dream/config.dart';
import 'package:dream/services/models/resource.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<ResourceModelQueryResult> queryPictures(String group) async {
  var url = Uri.parse('${AppConfig.serverUrl}/restful/resources/query');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "page": 1,
        "group": group,
        "query": "",
      }));
  if (kDebugMode) {
    print('Response status: ${response.statusCode}');
  }

  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  var count = decodedResponse['count'];
  Iterable list = decodedResponse['list'] as List;

  print('count: $count');
  var result = ResourceModelQueryResult.fromJson(decodedResponse);
  return result;
}

enum EmotionFilterGroup {
  folder(0),
  filter(1),
  tag(2);

  final int value;

  const EmotionFilterGroup(this.value);
}

class EmotionFilter {
  String pk;
  String title;
  int count;
  EmotionFilterGroup group;
  String icon;

  EmotionFilter(this.pk,
      {this.title = "",
      this.count = 0,
      this.group = EmotionFilterGroup.folder,
      this.icon = "static/images/icons/folder.svg"});

  static EmotionFilter fromJson(json) {
    return EmotionFilter(json["pk"], title: json["title"], count: json["file"]);
  }
}

Future<List<EmotionFilter>> queryEmotionFilters() {
  var list = <EmotionFilter>[];
  list.add(EmotionFilter("0",
      title: "所有图片",
      count: 3258,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("1",
      title: "动图",
      count: 19,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("2",
      title: "Images",
      count: 2190,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("3",
      title: "搞笑",
      count: 182,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("4",
      title: "骚气图片",
      count: 781,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("5",
      title: "沙雕图片",
      count: 2819,
      group: EmotionFilterGroup.folder,
      icon: "static/images/icons/folder.svg"));
  list.add(EmotionFilter("6",
      title: "大图片",
      count: 3781,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/bigimg.svg"));
  list.add(EmotionFilter("7",
      title: "屏幕截图",
      count: 123,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/jietu.svg"));
  list.add(EmotionFilter("8",
      title: "人物",
      count: 681,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/renwu.svg"));
  list.add(EmotionFilter("dongwu",
      title: "动物",
      count: 413,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/dongwu.svg"));
  list.add(EmotionFilter("wenzi",
      title: "带文字",
      count: 1270,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/wenzi.svg"));
  list.add(EmotionFilter("chongfu",
      title: "重复图片",
      count: 57,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/chongfu.svg"));
  list.add(EmotionFilter("shanchu",
      title: "已删除",
      count: 35,
      group: EmotionFilterGroup.filter,
      icon: "static/images/icons/lajitong.svg"));
  list.add(EmotionFilter("shoucang",
      title: "收藏",
      count: 189,
      group: EmotionFilterGroup.tag,
      icon: "static/images/icons/shoucang.svg"));
  list.add(EmotionFilter("hao",
      title: "好",
      count: 495,
      group: EmotionFilterGroup.tag,
      icon: "static/images/icons/hao.svg"));
  // list.add(EmotionFilter("zhong",
  //     title: "中",
  //     count: 672,
  //     group: EmotionFilterGroup.tag,
  //     icon: "static/images/icons/zhong.svg"));
  list.add(EmotionFilter("cha",
      title: "差",
      count: 71,
      group: EmotionFilterGroup.tag,
      icon: "static/images/icons/cha.svg"));

  return Future(() => list);
}
