import 'package:dream/application/web/pages/partial/header.dart';
import 'package:dream/application/web/providers/emotion.dart';
import 'package:dream/services/emotions/emotions.dart';
import 'package:dream/services/models/picture.dart';
import 'package:dream/services/models/resource.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'item.dart';
import 'partial/main_container.dart';

class ResourcesPage extends ConsumerWidget {
  final int indexPageSize = 10;
  int currentPage = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectKey = ref.watch(weEmotionProvider);
    var layoutHelper = LayoutHelper(context);
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const HeaderWidget(),
            MainContainer(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<ResourceModelQueryResult>(
                    future: queryPictures(selectKey),
                    builder: (BuildContext context,
                        AsyncSnapshot<ResourceModelQueryResult> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        debugPrint("hasData: ${snapshot.data}");
                        var result = snapshot.data!;
                        return LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            var maxCrossAxisExtent = 120.0;
                            var axisSpacing = 8.0;
                            debugPrint(
                                "constraints: ${constraints.maxWidth} ${constraints.maxHeight}");
                            var cols =
                                (constraints.maxWidth / maxCrossAxisExtent)
                                    .floor();
                            var rows = (result.count / cols).ceil();
                            debugPrint("cols: $cols ${result.count} ${rows}");
                            return Container(
                                height: rows *
                                    (maxCrossAxisExtent + axisSpacing + 32),
                                padding: EdgeInsets.all(16),
                                child: StaggeredGrid.count(
                                    crossAxisCount: layoutHelper.getGridColumns,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    children: snapshot.data!.list
                                        .map(
                                          (e) => StaggeredGridTile.count(
                                            crossAxisCellCount: 2,
                                            mainAxisCellCount: 2,
                                            child: ImageCellWidget(e),
                                          ),
                                        )
                                        .toList()));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("加载出错3 ${snapshot.error}"),
                        );
                      } else {
                        return Center(
                          child: Text("正在加载"),
                        );
                      }
                    },
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
