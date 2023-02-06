import 'dart:io';

import 'package:venus/application/providers/emotion.dart';
import 'package:venus/services/folder.dart';
import 'package:venus/services/models/folder.dart';
import 'package:venus/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart' as path;

final StateProvider<String> directoryProvider = StateProvider((_) => "");

class VFoldersWidget extends ConsumerWidget {
  const VFoldersWidget({Key? key}) : super(key: key);

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
                        addFolder('abc中国你好hello', '/abc/hello', 'abc.ico');
                        // var folder = await pickFolder();
                        // if (folder != null) {
                        //   ref
                        //       .read(directoryProvider.notifier)
                        //       .update((state) => folder.path);
                        // }
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
                        onTap: () {
                          debugPrint("点击动图");
                          ref
                              .read(folderProvider.notifier)
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

  Future<FolderModel?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      debugPrint("selectedDirectory: $selectedDirectory");

      final secureBookmarks = SecureBookmarks();
      final bookmark = await secureBookmarks.bookmark(File(selectedDirectory));

      var pk = generateRandomString(16);
      var newFolder = FolderModel(pk,
          title: path.basename(selectedDirectory),
          count: 182,
          icon: "static/images/icons/folder.svg",
          path: selectedDirectory,
          bookmark: bookmark);
      await insertFolder(newFolder);

      return newFolder;
    }

    return null;
  }
}
