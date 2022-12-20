import 'dart:convert';

import 'package:dream/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable()
class PictureModel {
  String file = "";

  PictureModel();

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureModelToJson(this);
}

@JsonSerializable()
class PictureQueryResult {
  List<PictureModel> list = [];
  int count = 0;

  PictureQueryResult();

  factory PictureQueryResult.fromJson(Map<String, dynamic> json) =>
      _$PictureQueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$PictureQueryResultToJson(this);
}

Future<PictureQueryResult> queryPictures(String group) async {
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
  var result = PictureQueryResult.fromJson(decodedResponse);
  return result;
}
