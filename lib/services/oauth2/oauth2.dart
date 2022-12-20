import 'package:dream/config.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:pillow/pillow.dart';

Future<void> goAuth() async {
  // final pkcePair = PkcePair.generate(length: 64);
  // debugPrint("codeVerifier: ${pkcePair.codeVerifier}");
  // debugPrint("codeChallenge: ${pkcePair.codeChallenge}");

  // var state = generateRandomString(16);
  // var nonce = generateRandomString(16);
  // debugPrint("state: $state");
  // debugPrint("nonce: $nonce");

  // final queryParameters = {
  //   "client_id": "pwa",
  //   "redirect_uri": "${AppConfig.serverUrl}/login/callback",
  //   "response_type": "code",
  //   "scope": "openid",
  //   "state": state,
  //   "nonce": nonce,
  //   "code_challenge": pkcePair.codeChallenge,
  //   "code_challenge_method": "S256"
  // };
  // final authUri =
  //     Uri.https(AppConfig.authHost, '/oauth2/auth', queryParameters);

  // todo 这里似乎需要修改。似乎应该通过后端接口的返回url来手动跳转，而不是后端自动返回302
  //final authUri = Uri.https(AppConfig.serverHost, '/pwa/login/begin', {});
  var authUri = Uri.parse(AppConfig.authUrl + "/pwa/login/begin");
  Pillow.openUrl(authUri);
}
