
import 'dart:io';

import 'package:flutter/material.dart';

class NImageWidget extends StatelessWidget {
  final String imagePath;
  const NImageWidget(this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      return Image.file(imageFile ,
        fit: BoxFit.fill, );
    }

    return Image.asset("static/images/avatar.jpeg");
  }
}
