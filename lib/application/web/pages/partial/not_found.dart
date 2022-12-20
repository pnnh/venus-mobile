import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart'; 

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);
    return Center(
      child: Column(children: [
        Text("资源不存在"),
        TextButton(
          child: const Text(
            "返回首页",
          ),
          style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: () async {
            routerDelegate.go("/");
          },
        )
      ]),
    );
  }
}
 