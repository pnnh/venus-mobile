import 'dart:io';

import 'package:dream/services/models/picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import '../providers/emotion.dart';

class MPicturesPage extends StatefulWidget {
  const MPicturesPage({Key? key}) : super(key: key);

  @override
  State<MPicturesPage> createState() => _MPicturesPageState();
}

class _MPicturesPageState extends State<MPicturesPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("current directory: ${Directory.current}");
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: Row(children: [
              Expanded(child: _PicturesGrid()),
            ]))
          ],
        ));
  }
}

class _PicturesGrid extends ConsumerWidget {
  const _PicturesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        height: 4000,
        child: FutureBuilder<List<PictureModel>>(
          future: selectPics(ref.watch(folderProvider)),
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
              children: picList.map((e) => _PicturesImageCell(e)).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _PicturesImageCell extends ConsumerWidget {
  final PictureModel model;
  late final TextEditingController _controller;
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Color.fromRGBO(240, 240, 240, 100),
        width: 1,
        style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  );

  _PicturesImageCell(this.model, {Key? key}) : super(key: key) {
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
