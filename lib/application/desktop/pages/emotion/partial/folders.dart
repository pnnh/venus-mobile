import 'package:dream/services/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

final StateProvider<List<PictureFolder>> counterProvider =
    StateProvider((_) => <PictureFolder>[]);

class VFoldersWidget extends ConsumerWidget {
  const VFoldersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var folderList = ref.watch(counterProvider);

    return FutureBuilder<List<PictureFolder>>(
        future: queryPictureFolders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("加载Folders出错"),
            );
          }
          var dataList = snapshot.data as List<PictureFolder>;
          return Column(
            children: [
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
                    GestureDetector(
                      onTap: () async {
                        debugPrint("plus");
                        var folder = await selectFolder();
                        if (folder != null)
                          ref.read(counterProvider).add(folder);
                      },
                      child: SvgPicture.asset(
                        "static/images/icons/plus.svg",
                        color: Color(0xffCDCDCD),
                        height: 16,
                        width: 16,
                        //    fit: BoxFit.fitWidth
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Column(
                  children: List.generate(
                dataList.length,
                (index) {
                  var item = dataList[index];

                  return Container(
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
                                .selectKey(item.path);
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
                    ),
                  );
                },
              ))
            ],
          );
        });
  }
}
