import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WPSizeFilterWidget extends ConsumerWidget {
  const WPSizeFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 144,
      height: 24,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Color(0xffececec), width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 24,
              padding: EdgeInsets.zero,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("小", style: TextStyle(fontSize: 12))],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "中",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("大", style: TextStyle(fontSize: 12))],
              ),
            ),
          )
        ],
      ),
    );
  }
}
