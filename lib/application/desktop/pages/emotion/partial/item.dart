import 'package:flutter/material.dart';
import 'dart:io';

class ImageCellWidget extends StatefulWidget {
  final String imageUri;

  const ImageCellWidget(this.imageUri, {Key? key}) : super(key: key);

  @override
  State<ImageCellWidget> createState() => _ImageCellWidget();
}

class _ImageCellWidget extends State<ImageCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.all(1),
        child: Image(
          image: FileImage(File(widget.imageUri)),
          fit: BoxFit.fill,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: Color(0xFFD7D7D7), width: 1),
        ));
  }
}
