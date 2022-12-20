import 'package:dream/services/home.dart';
import 'package:dream/services/models/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:split_view/split_view.dart';

import 'partial/header.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AdminHeaderWidget(),
        Expanded(
            child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(color: const Color(0xffd7d7d7)),
                              bottom:
                                  BorderSide(color: const Color(0xffd7d7d7)))),
                      width: 256,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text("资源管理器"),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: const Color(0xffd7d7d7)),
                                      bottom: BorderSide(
                                          color: const Color(0xffd7d7d7)))),
                              child: Row(children: [
                                SvgPicture.asset(
                                  "static/images/icons/arrow_down.svg",
                                ),
                                const SizedBox(width: 8),
                                Text("位置"),
                              ]),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 24, right: 8),
                              child: Row(children: [
                                SvgPicture.asset(
                                  "static/images/icons/home.svg",
                                ),
                                const SizedBox(width: 8),
                                Text("主目录"),
                              ]),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 24, right: 8),
                              child: Row(children: [
                                SvgPicture.asset(
                                  "static/images/icons/picture.svg",
                                ),
                                const SizedBox(width: 8),
                                Text("图片"),
                              ]),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 24, right: 8),
                              child: Row(children: [
                                SvgPicture.asset(
                                  "static/images/icons/document.svg",
                                ),
                                const SizedBox(width: 8),
                                Text("文档"),
                              ]),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 24, right: 8),
                              child: Row(children: [
                                SvgPicture.asset(
                                  "static/images/icons/trash_fill.svg",
                                  height: 16,
                                ),
                                const SizedBox(width: 8),
                                Text("回收站"),
                              ]),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              Expanded(child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 48,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: const Color(0xffd7d7d7)))),
                          child: Row(children: [
                            SvgPicture.asset(
                              "static/images/icons/trash_fill.svg",
                              height: 16,
                            ),
                            Text("右侧上方区域")
                          ]),
                        ),
                        Expanded(
                            child: SplitView(
                          viewMode: SplitViewMode.Vertical,
                          indicator: const SplitIndicator(
                              viewMode: SplitViewMode.Vertical),
                          gripSize: 2,
                          gripColor: const Color(0XFFEEEEEE),
                          gripColorActive: const Color(0XFFEEEEEE),
                          activeIndicator: const SplitIndicator(
                            viewMode: SplitViewMode.Vertical,
                            isActive: true,
                          ),
                          controller: SplitViewController(limits: [
                            WeightLimit(min: 0.2, max: 0.5),
                            WeightLimit(min: 0.1)
                          ]),
                          onWeightChanged: (w) => debugPrint("Horizontal $w"),
                          children: [
                            Container(
                              child: Text("右侧中间区域"),
                            ),
                            Container(
                              child: Text("右侧下方区域"),
                            ),
                          ],
                        ))
                      ],
                    )), // your column
                  );
                },
              ))
            ],
          ),
        )),
        Row(
          children: [
            Expanded(
                child: Container(
                    height: 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "304ff1f7_E995882_2e1b2fa7.jpg (JPEG图像, 142.9 KB, 2022-10-31 16:35:54)",
                            style: TextStyle(
                                color: Color(0xff767676), fontSize: 13))
                      ],
                    )))
          ],
        )
      ],
    );
  }
}
