import 'package:dream/application/web/providers/emotion.dart';
import 'package:dream/services/emotions/emotions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WELeftSideWidget extends ConsumerWidget {
  const WELeftSideWidget({Key? key}) : super(key: key);

  final Color selectedColor = const Color.fromRGBO(0, 119, 212, 100);
  final Color defaultColor = const Color.fromRGBO(146, 148, 152, 100);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<EmotionFilter>>(
        future: queryEmotionFilters(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //debugPrint("pics: ${snapshot.data}");
          if (!snapshot.hasData) {
            return Center(
              child: Text("Empty"),
            );
          }
          var filtersList = snapshot.data as List<EmotionFilter>;
          var list = <EmotionFilter>[EmotionFilter("folders", title: "常用文件夹")];
          list.addAll(filtersList
              .where((element) => element.group == EmotionFilterGroup.folder));
          list.add(EmotionFilter("filters", title: "筛选"));
          list.addAll(filtersList
              .where((element) => element.group == EmotionFilterGroup.filter));
          list.add(EmotionFilter("tags", title: "标签"));
          list.addAll(filtersList
              .where((element) => element.group == EmotionFilterGroup.tag));
          return Container(
              width: 200,
              padding: EdgeInsets.only(top: 24, left: 0, bottom: 24, right: 0),
              child: Column(
                  children: list.map((e) {
                if (e.pk == "folders") {
                  return Container(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "文件夹",
                          style: TextStyle(fontSize: 14),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, right: 0, top: 0, bottom: 0),
                          child: GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                "static/images/icons/plus.svg",
                                color: Color(0xff444444),
                                height: 16,
                                width: 16,
                                //    fit: BoxFit.fitWidth
                              )),
                        ),
                      ],
                    ),
                  );
                } else if (e.pk == "filters") {
                  return Container(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "筛选",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                } else if (e.pk == "tags") {
                  return Container(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "标签",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  height: 32,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (event) {
                      //ref.read(weEmotionProvider.notifier).hover(e.pk);
                      ref.read(wpEmotionHoverProvider.notifier).setKey(e.pk);
                    },
                    onExit: (event) {
                      //ref.read(weEmotionProvider.notifier).hover("");
                      ref.read(wpEmotionHoverProvider.notifier).setKey("");
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, right: 8, top: 0, bottom: 0),
                          child: SvgPicture.asset(
                            e.icon,
                            color: Color(0xff444444),
                            height: 16,
                            width: 16,
                            //    fit: BoxFit.fitWidth
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("点击${e.title}");
                            ref.read(weEmotionProvider.notifier).select(e.pk);
                          },
                          child: Text(
                            "${e.title}(${e.count})",
                            style: TextStyle(
                                color: ref.watch(weEmotionProvider) == e.pk ||
                                        ref.watch(wpEmotionHoverProvider) ==
                                            e.pk
                                    ? Color(0xff009cff)
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList()));
        });
  }
}
