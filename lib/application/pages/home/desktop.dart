
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/title_bar.dart';
import '../../components/work_group.dart';
import 'desktop/emotion.dart';

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
                    child: EmotionPage()))
          ],
        ));
  }
}
