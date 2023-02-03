import 'dart:io';

import 'package:dream/application/providers/emotion.dart';
import 'package:dream/services/models/folder.dart';
import 'package:dream/services/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';

class EmotionGridWidget extends ConsumerWidget {
  const EmotionGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        height: 4000,
        child: FutureBuilder<List<PictureModel>>(
          future: _selectPics(ref.watch(folderProvider)),
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
              children: picList.map((e) => ImageCellWidget(e)).toList(),
            );
          },
        ),
      ),
    );
  }

  Future<List<PictureModel>> _selectPics(PictureFolder folder) async {
    if (Platform.isMacOS) {
      await macosAccessingSecurityScopedResource(folder.bookmark);
    }
    return selectPics(folder.path);
  }
}
