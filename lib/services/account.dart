import 'dart:convert';

import 'package:dream/config.dart';
import 'package:dream/services/models/authorization.dart';
import 'package:http/http.dart' as http;

Future<bool> doLogin(String account, String token) async {
  var url = Uri.parse('${AppConfig.serverUrl}/pwa/account/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'account': account, 'code': token}));
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var tokenType = decodedResponse['token_type'];
  var accessToken = decodedResponse['access_token'];
  print('status: $accessToken');
  //await IsarStore.insertAuthorization(tokenType, accessToken);
  return true;
}

// todo 暂未用到
Future<bool> doLoginBegin(String account, String token) async {
  var url = Uri.parse('${AppConfig.serverUrl}/pwa/account/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'account': account, 'code': token}));
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var tokenType = decodedResponse['token_type'];
  var accessToken = decodedResponse['access_token'];
  print('status: $accessToken');
  //await IsarStore.insertAuthorization(tokenType, accessToken);
  return true;
}

Future<String> doLoginFinish(String code) async {
  var current = await AuthorizationStore.findCurrent();
  if (current != null) {
    return current.accessToken;
  }
  var url = Uri.parse('${AppConfig.serverUrl}/pwa/login/finish');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}));
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var user = decodedResponse['user'];
  print('user: $user');
  await AuthorizationStore.setCurrent(accessToken: user);
  //await IsarStore.insertAuthorization(tokenType, accessToken);
  return user;
}
