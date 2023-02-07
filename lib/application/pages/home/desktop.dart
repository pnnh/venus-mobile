
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venus/application/components/image.dart';
import 'package:venus/services/models/picture.dart';

import '../../components/title_bar.dart';

import 'package:path/path.dart';
import 'package:venus/application/providers/emotion.dart';
import 'package:venus/services/folder.dart';
import 'package:venus/services/models/folder.dart';
import 'package:venus/services/picture.dart';
import 'package:venus/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart' as path;


final StateProvider<String> directoryProvider = StateProvider((_) => "");

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
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            //const TitleBarWidget(),
                            Expanded(
                                child: Row(children: [
                                  _ELeftSideWidget(),
                                  Expanded(child: _EmotionGridWidget()),
                                ]))
                          ],
                        ))))
          ],
        ));
  }
}


class _ELeftSideWidget extends ConsumerWidget {
  const _ELeftSideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 256,
      color: const Color(0xffF4F0EE),
      padding: EdgeInsets.only(top: 24, left: 0, bottom: 24, right: 0),
      child: Column(children: [
        _VFoldersWidget(),
        //VFiltersWidget(),
      ]),
    );
  }
}


class _VFoldersWidget extends ConsumerWidget {
  const _VFoldersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<FolderModel>>(
        future: queryFolders(ref.watch(directoryProvider)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("加载Folders出错"),
            );
          }
          var dataList = snapshot.data as List<FolderModel>;
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
                        var folder = await pickFolder();
                        if (folder != null) {
                          ref.read(directoryProvider.notifier)
                              .update((state) => folder.path);
                        }
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
                      debugPrint("item: ${item.path}");

                      return MouseRegion(
                          child: Container(
                            height: 32,
                            padding: EdgeInsets.only(left: 16, right: 16),
                            color: ref.watch(folderProvider).pk == item.pk
                                ? Color(0xffD3D3D3)
                                : Colors.transparent,
                            child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  debugPrint("点击动图");
                                  // 执行扫描文件夹的任务
                                  await scanPicturesWorker(item);
                                  ref.read(folderProvider.notifier)
                                      .update((state) => item);
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
                                            "static/images/icons/folder.svg",
                                            color: Color(0xff444444),
                                            height: 16,
                                            width: 16,
                                            //    fit: BoxFit.fitWidth
                                          ),
                                        ),
                                        Text(
                                          basename(item.path),
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

  Future<FolderModel?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      debugPrint("selectedDirectory: $selectedDirectory");

      final secureBookmarks = SecureBookmarks();
      final bookmark = await secureBookmarks.bookmark(File(selectedDirectory));

      var pk = generateRandomString(16);
      var newFolder = FolderModel(pk,
          path: selectedDirectory,
          bookmark: bookmark);
      await insertFolder(newFolder);

      return newFolder;
    }

    return null;
  }
}

class _EmotionGridWidget extends ConsumerWidget {
  const _EmotionGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        height: 4000,
        child: FutureBuilder<List<PictureModel>>(
          future: selectPicturesByFolder(ref.watch(folderProvider).pk),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //debugPrint("pics: ${snapshot.data}");
            if (!snapshot.hasData) {
              return Center(
                child: Text("Empty"),
              );
            }
            var picList = snapshot.data as List<PictureModel>;
            return GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120.0,
                childAspectRatio: 1.0,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              physics: NeverScrollableScrollPhysics(),
              children: picList.map((e) => _ImageCellWidget(e)).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _ImageCellWidget extends ConsumerWidget {
  final PictureModel model;
  late final TextEditingController _controller;
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Color.fromRGBO(240, 240, 240, 100),
        width: 1,
        style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  );
  _ImageCellWidget(this.model, {Key? key}) : super(key: key) {
    _controller = TextEditingController(text: path.basename(model.path));
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pk = ref.watch(gridProvider);
    return Column(children: [
      Expanded(
        child: Container(
          child: NImageWidget(model.fullPath),
        ),
      ),
      if (pk == model.pk)
        Container(
          height: 32,
          padding: const EdgeInsets.all(8),
          child: TextField(
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 14),
            autofocus: true,
            decoration: InputDecoration(
              hoverColor: Colors.white,
              hintText: '搜索图片',
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.all(0),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: searchBorder,
              focusedBorder: searchBorder,
              focusedErrorBorder: searchBorder,
              border: searchBorder,
            ),
            controller: _controller,
          ),
        )
      else
        GestureDetector(
          onTap: () {
            ref.read(gridProvider.notifier).update((state) => model.pk);
            _controller.selection = TextSelection(
                baseOffset: 0, extentOffset: _controller.value.text.length);
          },
          child: Container(
            height: 32,
            padding: const EdgeInsets.all(8),
            child: Tooltip(
              message: _controller.text,
              child: Text(
                _controller.text,
                softWrap: false,
                style: const TextStyle(
                    color: Color.fromARGB(255, 104, 104, 104),
                    fontSize: 12,
                    overflow: TextOverflow.fade),
              ),
            ),
          ),
        )
    ]);
  }
}