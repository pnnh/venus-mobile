import 'dart:io';

import 'package:flutter/material.dart';

import './partial/left_side.dart';
import '../../components/title_bar.dart';
import 'partial/emotion_grid.dart';

class EmotionPage extends StatefulWidget {
  const EmotionPage({Key? key}) : super(key: key);

  @override
  State<EmotionPage> createState() => _EmotionPageState();
}

class _EmotionPageState extends State<EmotionPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("current directory: ${Directory.current}");
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const TitleBarWidget(),
            Expanded(
                child: Row(children: [
              ELeftSideWidget(),
              Expanded(child: EmotionGridWidget()),
            ]))
          ],
        ));
  }
}
