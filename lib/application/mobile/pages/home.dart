import 'package:flutter/material.dart';

import '../components/work_group.dart';

class EmotionPage extends StatelessWidget {
  const EmotionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmotionScreen();
  }
}

class EmotionScreen extends StatelessWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: GestureDetector(
                    onTapDown: (detail) {
                      debugPrint("out click");
                    },
                    child: Row(children: [
                      Container(
                          width: 56,
                          padding: const EdgeInsets.only(top: 8),
                          color: const Color.fromRGBO(242, 246, 255, 100),
                          child: const WorkGroupWidget()),
                    ])))
          ],
        ));
  }
}
