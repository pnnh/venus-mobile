import 'dart:math';

import 'package:dream/services/folder.dart';
import 'package:dream/services/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

final StateProvider<String> _directoryProvider = StateProvider((_) => "");

class MHomePage extends ConsumerWidget {
  const MHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size screenSize = MediaQuery.of(context).size;
        print("screenSize $screenSize");

        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              height: max(512, constraints.maxHeight)),
          child: Scaffold(
            body: Scaffold(
              appBar: AppBar(
                title: const Text("选择文件夹"),
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const _MFoldersPartial(),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                debugPrint("点击按钮");

                                var folder = await Folders.pickFolder();
                                if (folder != null) {
                                  debugPrint("选择了文件夹: ${folder.path}");
                                  ref
                                      .read(_directoryProvider.notifier)
                                      .update((state) => folder.path);
                                } else {
                                  debugPrint("什么都没有选择");
                                }
                              },
                              child: Text("点击"),
                            ),
                          )
                        ],
                      ))),
            ),
            backgroundColor: const Color(0xffFAFAFA),
          ), // your column
        );
      },
    );

  }
}

class _MFoldersPartial extends ConsumerWidget {
  const _MFoldersPartial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<PictureFolder>>(
        future: selectFolders(ref.watch(_directoryProvider)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("加载Folders出错"),
            );
          }
          var dataList = snapshot.data as List<PictureFolder>;
          return Column(
            children: [
              Column(
                  children: List.generate(
                dataList.length,
                (index) {
                  var item = dataList[index];
                  debugPrint("item: ${item.path}");

                  return MouseRegion(
                      child: Container(
                    height: 32,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    color: Colors.transparent,
                    child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          debugPrint("点击动图");
                          context.go("/pictures/${item.pk}");
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
                                    item.icon,
                                    color: Color(0xff444444),
                                    height: 16,
                                    width: 16,
                                    //    fit: BoxFit.fitWidth
                                  ),
                                ),
                                Text(
                                  item.title,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Text(item.count.toString())
                          ],
                        )),
                  ));
                },
              ))
            ],
          );
        });
  }
}

