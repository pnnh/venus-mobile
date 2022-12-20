import 'dart:convert';

import 'package:dream/config.dart';
import 'package:dream/services/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'models/home.dart';

Future<HomeResult> queryHome(int page) async {
  var url = Uri.parse('${AppConfig.serverUrl}/pwa/restful/resources/query');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "page": page,
      }));
  print('Response status: ${response.statusCode}');

  var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  // var count = decodedResponse['count'];
  // Iterable list = decodedResponse['list'] as List;

  //print('count: $count');
  var result = HomeResult.fromJson(decodedResponse);
  return result;
}
