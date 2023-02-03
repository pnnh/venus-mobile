import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WPUploadButtonWidget extends ConsumerWidget {
  WPUploadButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 64,
      height: 24,
      decoration: BoxDecoration(
          color: Color(0xff009CFF),
          border: Border.all(
              color: Color(0xffececec), width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4)),
      //padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "上传",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
