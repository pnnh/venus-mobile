import 'package:dream/application/web/pages/partial/header.dart';
import 'package:dream/application/web/pages/partial/page_loading.dart';
import 'package:dream/application/web/route.dart';
import 'package:dream/services/account.dart';
import 'package:dream/services/oauth2/oauth2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class CallbackWidget extends StatefulWidget {
  const CallbackWidget({Key? key}) : super(key: key);

  @override
  State<CallbackWidget> createState() => _CallbackWidgetState();
}

class _CallbackWidgetState extends State<CallbackWidget> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);
    String myurl = Uri.base.toString(); //get complete url
    var queryCode = Uri.base.queryParameters["code"];
    debugPrint("myurl: $myurl");
    debugPrint("queryCode: $queryCode");

    if (queryCode == null || queryCode!.isEmpty) {
      return Container(
        child: Text("出现错误，code为空"),
      );
    }

    return FutureBuilder<String>(
        future: doLoginFinish(queryCode),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return Text("加载出错1 ${snapshot.error}");
          }

          if (!snapshot.hasData) {
            return PageLoadingWidget();
          }
          //debugPrint("result ${result.data}");
          var model = snapshot.data;
          if (model == null) {
            return Center(
              child: Text("登录出错"),
            );
          } else {
            Future.microtask(() => routerDelegate.go("/"));
            return Center(
              child: Text("登录成功，即将发生跳转: $model"),
            );
          }
        });

    // return Container(
    //   child: Text("callback page"),
    // );
    // return FutureBuilder<List<EmotionPicture>>(
    //     future: doCallback(account, token),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {});
  }
}
