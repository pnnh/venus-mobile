import 'package:dream/application/desktop/providers/emotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VFoldersWidget extends ConsumerWidget {
  const VFoldersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedKey = "";
    return Container(
      child: Column(children: [
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "位置",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
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
      ]),
    );
  }
}
