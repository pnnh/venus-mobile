import 'dart:io';
import 'dart:math';

import 'package:dream/application/pages/partial/page_loading.dart';
import 'package:dream/services/folder.dart';
import 'package:dream/services/models/folder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:dream/services/home.dart';
import 'package:dream/services/models/home.dart';

import '../components/title_bar.dart';
import '../components/work_group.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       // appBar: AppBar(
       //   title: const Text("选择文件夹"),
       // ),
       body: SafeArea(
         child: HomeBody(),
       ),
     );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return const MobileHomeBody();
    } else if (kIsWeb) {
      return const WebHomeBody();
    }
    return const DesktopHomeBody();
  }
}

final StateProvider<String> _directoryProvider = StateProvider((_) => "");

class WebHomeBody extends StatefulWidget {
  const WebHomeBody({Key? key}) : super(key: key);

  @override
  State<WebHomeBody> createState() => _WebHomeBodyState();
}

class _WebHomeBodyState extends State<WebHomeBody> {
  final int indexPageSize = 10;
  int currentPage = 1;
  int totalMainAxisCellCount = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeResult>(
      future: queryHome(currentPage),
      builder: (BuildContext context, AsyncSnapshot<HomeResult> snapshot) {
        if (snapshot.hasError) {
          return Text("加载出错2 ${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return PageLoadingWidget();
        }
        //debugPrint("result ${result.data}");
        final int dataCount = snapshot.data?.count ?? 0;

        var repositories = snapshot.data?.list ?? [];

        return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(child: Text("尚未实现")));
      },
    );
  }

  Widget renderPagination(BuildContext context, int articlesCount) {
    int maxPage = articlesCount ~/ indexPageSize;
    if (articlesCount % indexPageSize != 0) {
      maxPage += 1;
    }
    if (currentPage > maxPage) {
      currentPage = maxPage;
    }
    int startPage = currentPage - 5;
    int endPage = currentPage + 5;

    if (startPage < 1) {
      startPage = 1;
    }
    if (endPage > maxPage) {
      endPage = maxPage;
    }
    int prevPage = currentPage - 1;
    int nextPage = currentPage + 1;
    debugPrint("pages $currentPage $prevPage $nextPage $maxPage");

    return Row(
      children: [
        if (prevPage >= 1)
          Container(
            height: 32,
            width: 32,
            child: TextButton(
                child: Text("«"),
                onPressed: () {
                  debugPrint("prevPage $prevPage");
                  //callback(prevPage);
                  setState(() {
                    currentPage = prevPage;
                  });
                }),
          ),
        for (int n = startPage; n <= endPage; ++n)
          Container(
              height: 32,
              width: 32,
              color: currentPage == n ? Color(0xff55A0E6) : Colors.transparent,
              child: TextButton(
                  style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent)),
                  child: Text(n.toString(),
                      style: TextStyle(
                          color: currentPage == n
                              ? const Color(0xffffffff)
                              : Colors.black)),
                  onPressed: () {
                    debugPrint("currentPage $n");
                    //callback(n);
                    setState(() {
                      currentPage = n;
                    });
                  })),
        if (nextPage <= maxPage)
          Container(
            height: 32,
            width: 32,
            child: TextButton(
                child: Text(
                  "»",
                ),
                onPressed: () {
                  debugPrint("nextPage $nextPage");
                  //callback(nextPage);
                  setState(() {
                    currentPage = nextPage;
                  });
                }),
          ),
      ],
    );
  }
}


class MobileHomeBody extends ConsumerWidget {
  const MobileHomeBody({Key? key}) : super(key: key);

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
            appBar: AppBar(
              title: const Text("选择文件夹"),
            ),
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


class DesktopHomeBody extends StatelessWidget {
  const DesktopHomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const TitleBarWidget(),
            Expanded(
                child: GestureDetector(
                    onTapDown: (detail) {
                      debugPrint("out click");
                    },
                    child: Row(children: [
                      Container(
                          width: 56,
                          padding: const EdgeInsets.only(top: 8),
                          color: const Color.fromRGBO(242, 246, 255, 100),
                          child: const WorkGroupWidget()),
                    ])))
          ],
        ));
  }
}
