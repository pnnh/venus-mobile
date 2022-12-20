import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../config.dart';
import 'models/article.dart';

Future<List<ArticleModel>> loadArticles(int created) async {
  var queryMap = <String, dynamic>{};
  queryMap["created"] = created;

  var queryJsonStr = json.encode(queryMap);

  debugPrint("queryJson $queryJsonStr");

  var loadUri = Uri.dataFromString("${AppConfig.serverUrl}/pwa/api/query");
  var resp = await http.post(loadUri, body: queryJsonStr);

  List<dynamic> data = json.decode(resp.body);
  var result = List.filled(data.length, ArticleModel());
  if (resp.statusCode != 200) {
    debugPrint("loadArticles返回错误 ${resp.statusCode}");
    return result;
  }

  for (var element in data) {
    var info = ArticleModel();
    //info.content = element['data']['content'];
    info.created = element['created'];
    result.add(info);
    //debugPrint("jjjj2 ${info.content} ${info.created}");
  }
  return result;
}

Future<void> saveArticle(String content) async {
  if (content == "") return;

  var article = ArticleModel();
  //article.content = content;

  var artJson = json.encode(article);

  debugPrint("jjj $artJson");

  var loadUri = Uri.dataFromString("${AppConfig.serverUrl}/pwa/api/add");
  var resp = await http.post(loadUri, body: artJson);

  debugPrint("cccc $resp");
}

Future<ArticleFindResult?> findArticle(String pk) async {
  if (pk == "") return null;
  var url = Uri.parse('${AppConfig.serverUrl}/pwa/restful/articles/find');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "pk": pk,
      }));
  print('Response status: ${response.statusCode}');
  //print('Response status22: ${utf8.decode(response.bodyBytes)}');

  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  // var count = decodedResponse['count'];
  // Iterable list = decodedResponse['list'] as List;

  //print('count: $count');
  var result = ArticleFindResult.fromJson(decodedResponse);
  return result;
}

// 将纳秒时间戳转换为友好格式
String formatDateTime(int nanoseconds) {
  var timeStr =
      DateTime.fromMicrosecondsSinceEpoch((nanoseconds / 1000).round())
          .toString();
  return timeStr.substring(0, 16);
}
