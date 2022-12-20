import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/desktop/components/window.dart';
import 'package:dream/application/desktop/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleBarWidget extends StatefulWidget {
  const TitleBarWidget({Key? key}) : super(key: key);

  @override
  State<TitleBarWidget> createState() => _TitleBarWidget();
}

class _TitleBarWidget extends State<TitleBarWidget> {
  String content = "搜索笔记";

  final normalColor = const Color.fromRGBO(70, 70, 70, 100);
  final hoverBackground = const Color.fromRGBO(204, 204, 204, 100);
  final disableColor = const Color.fromRGBO(165, 165, 165, 100);
  final disableBackground = const Color.fromRGBO(217, 217, 217, 100);
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Color.fromRGBO(240, 240, 240, 100),
        width: 1,
        style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    var routerDelegate = DesktopRouterDelegate.of(context);
    return Container(
        height: 40,
        color: const Color.fromRGBO(231, 231, 231, 100),
        child: WindowTitleBarBox(
            child: Row(children: [
          Expanded(
              child: MoveWindow(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                //if (Platform.isMacOS) SizedBox(width: 5),
                Container(
                    padding: EdgeInsets.only(left: Platform.isMacOS ? 74 : 0),
                    //width: 120,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(2)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(24, 24)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                overlayColor:
                                    MaterialStateProperty.all(hoverBackground),
                              ),
                              onPressed: routerDelegate.isFirst()
                                  ? null
                                  : () {
                                      routerDelegate.back();
                                    },
                              child: SvgPicture.asset(
                                  "static/images/icons/arrow_left_s.svg",
                                  color: routerDelegate.isFirst()
                                      ? disableColor
                                      : normalColor)),
                          const SizedBox(width: 4),
                          TextButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(2)),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(24, 24)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                overlayColor:
                                    MaterialStateProperty.all(hoverBackground),
                              ),
                              onPressed: routerDelegate.isLast()
                                  ? null
                                  : () {
                                      routerDelegate.forward();
                                    },
                              child: SvgPicture.asset(
                                  "static/images/icons/arrow_right_s.svg",
                                  color: routerDelegate.isLast()
                                      ? disableColor
                                      : normalColor)),
                        ])),
                const Text("筑梦笔记"),
                Container(
                    width: 120,
                    height: 24,
                    padding: const EdgeInsets.only(right: 16),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        hintText: '搜索笔记',
                        hintStyle: const TextStyle(fontSize: 14),
                        contentPadding: const EdgeInsets.only(left: 8, top: 4),
                        enabledBorder: searchBorder,
                        focusedBorder: searchBorder,
                        focusedErrorBorder: searchBorder,
                        filled: true,
                        fillColor: Colors.white,
                        border: searchBorder,
                      ),
                      controller: TextEditingController(text: ""),
                    ))
              ]))),
          const WindowButtons() // 似乎在macOS下不太需要
        ])));
  }
}
