import 'package:dream/application/desktop/providers/emotion.dart';
import 'package:dream/application/desktop/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ELeftSideWidget extends ConsumerWidget {
  const ELeftSideWidget({Key? key}) : super(key: key);

  final Color selectedColor = const Color.fromRGBO(0, 119, 212, 100);
  final Color defaultColor = const Color.fromRGBO(146, 148, 152, 100);

  // void selectKey(WidgetRef ref, String key) {
  //   debugPrint("selectKey $key");
  //   ref.read(emotionProvider.state).state.selectedKey = key;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routerDelegate = DesktopRouterDelegate.of(context);
    debugPrint("work_group ${routerDelegate.currentConfiguration.uri}");
    var selectedKey = "";
    return Container(
      width: 256,
      color: const Color(0xffF4F0EE),
      padding: EdgeInsets.only(top: 24, left: 0, bottom: 24, right: 0),
      child: Column(children: [
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: ref.watch(emotionProvider) == "f1"
              ? Color(0xffD3D3D3)
              : Colors.transparent,
          child: MouseRegion(
            onEnter: (event) {},
            child: GestureDetector(
                onTap: () {
                  debugPrint("点击动图");
                  ref
                      .read(emotionProvider.notifier)
                      .selectKey('/Users/Larry/Downloads/data/');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, right: 8, top: 0, bottom: 0),
                          child: SvgPicture.asset(
                            "static/images/icons/home.svg",
                            color: Color(0xff444444),
                            height: 16,
                            width: 16,
                            //    fit: BoxFit.fitWidth
                          ),
                        ),
                        Text(
                          "主目录",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text("2819")
                  ],
                )),
          ),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: ref.watch(emotionProvider) == "f2"
              ? Color(0xffD3D3D3)
              : Colors.transparent,
          child: MouseRegion(
            onEnter: (event) {
              // setState(() {
              //   selectedKey = "f2";
              // });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
                      child: GestureDetector(
                          onTap: () {
                            debugPrint("点击Images");
                            ref
                                .read(emotionProvider.notifier)
                                .selectKey('/Users/Larry/Downloads/data2/1');
                          },
                          child: SvgPicture.asset(
                            "static/images/icons/download.svg",
                            color: Color(0xff444444),
                            height: 18,
                            width: 18,
                            //    fit: BoxFit.fitWidth
                          )),
                    ),
                    Text(
                      "下载",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
            height: 32,
            color: selectedKey == "f3" ? Color(0xffD3D3D3) : Colors.transparent,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "f3";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/picture.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "图片",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "saoqi" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "saoqi";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/document.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "文档",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "shadiao" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "shadiao";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/trash_fill.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "回收站",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "筛选",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "bigimg" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "bigimg";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/bigimg.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "大图片",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("2819")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "jietu" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "jietu";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/jietu.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "屏幕截图",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("123")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "renwu" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "renwu";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/renwu.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "人物",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("457")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "dongwu" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "dongwu";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/dongwu.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "动物",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("413")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "wenzi" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "wenzi";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/wenzi.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "带文字",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("1270")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color:
              selectedKey == "chongfu" ? Color(0xffD3D3D3) : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "chongfu";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/chongfu.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "重复图片",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("57")
                ],
              )),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: selectedKey == "lajitong"
              ? Color(0xffD3D3D3)
              : Colors.transparent,
          child: MouseRegion(
              onEnter: (event) {
                // setState(() {
                //   selectedKey = "lajitong";
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 8, top: 0, bottom: 0),
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "static/images/icons/lajitong.svg",
                              color: Color(0xff444444),
                              height: 16,
                              width: 16,
                              //    fit: BoxFit.fitWidth
                            )),
                      ),
                      Text(
                        "已删除",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("35")
                ],
              )),
        ),
      ]),
    );
  }
}
