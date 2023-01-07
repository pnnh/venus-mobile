import 'dart:io';

import 'package:dream/application/mobile/providers/emotion.dart';
import 'package:dream/services/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

class ImageCellWidget extends ConsumerWidget {
  final PictureModel model;
  late final TextEditingController _controller;
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Color.fromRGBO(240, 240, 240, 100),
        width: 1,
        style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  );

  ImageCellWidget(this.model, {Key? key}) : super(key: key) {
    _controller = TextEditingController(text: path.basename(model.file));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pk = ref.watch(gridProvider);
    return Column(children: [
      Expanded(
        child: Container(
          child: Image(
            image: FileImage(File(model.file)),
            fit: BoxFit.fill,
          ),
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
