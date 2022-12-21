import 'package:dream/application/desktop/providers/emotion.dart';
import 'package:dream/services/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ImageCellWidget extends ConsumerWidget {
  final PictureModel model;
  // late final TextEditingController _controller;

  ImageCellWidget(this.model, {Key? key}) : super(key: key) {
    // _controller = TextEditingController(text: path.basename(model.file));
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var pk = ref.watch(gridProvider);
    return Column(children: [
      Expanded(
        child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(Radius.circular(4)),
          //   border: Border.all(color: Color(0xFFD7D7D7), width: 1),
          // ),
          //padding: EdgeInsets.only(left: 24, right: 24),
          child: Image(
            image: FileImage(File(model.file)),
            fit: BoxFit.fill,
          ),
        ),
      ),
      //if (pk != model.pk)
      Container(
        padding: EdgeInsets.all(8),
        child: Tooltip(
          message: path.basename(model.file),
          child: Text(
            path.basename(model.file),
            softWrap: false,
            style: TextStyle(
                color: Color.fromARGB(255, 104, 104, 104),
                fontSize: 12,
                overflow: TextOverflow.fade),
          ),
        ),
      ),
      // if (pk == model.pk)
      //   Container(
      //     padding: EdgeInsets.all(8),
      //     child: Tooltip(
      //       message: path.basename(model.file),
      //       child: Text(
      //         "编辑模式",
      //         softWrap: false,
      //         style: TextStyle(
      //             color: Color.fromARGB(255, 104, 104, 104),
      //             fontSize: 12,
      //             overflow: TextOverflow.fade),
      //       ),
      //     ),
      //   )
    ]);
  }
}
