import 'package:dream/application/web/pages/partial/page_loading.dart';
import 'package:dream/services/home.dart';
import 'package:dream/services/models/home.dart';
import 'package:dream/services/models/resource.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../partial/header.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: Container(
                child: Column(
              children: [
                const HeaderWidget(),
                const SizedBox(height: 16),
                SizedBox(
                    width: 1200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                              //padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: StaggeredGrid.count(
                                  crossAxisCount: 24,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  children: repositories
                                      .map(
                                        (e) => StaggeredGridTile.count(
                                          crossAxisCellCount: 6,
                                          mainAxisCellCount: 6,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            child: ResourceItemWidget(e),
                                          ),
                                        ),
                                      )
                                      .toList())),
                        )
                      ],
                    )),
                Container(
                  width: 1200,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: renderPagination(context, dataCount),
                ),
                SizedBox(
                  height: 24,
                )
              ],
            )));
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
