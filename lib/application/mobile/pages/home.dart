import 'package:dream/services/folder.dart';
import 'package:flutter/material.dart';

class MHomePage extends StatelessWidget {
  const MHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: TextButton(
            onPressed: () async {
              debugPrint("点击按钮");

              var folder = await Folders.pickFolder();
              if (folder != null) {
                debugPrint("选择了文件夹: ${folder.path}");
              } else {
                debugPrint("什么都没有选择");
              }
            },
            child: Text("点击"),
          ),
        ));
  }
}
