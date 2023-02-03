
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'filters.dart';
import 'folders.dart';

class ELeftSideWidget extends ConsumerWidget {
  const ELeftSideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 256,
      color: const Color(0xffF4F0EE),
      padding: EdgeInsets.only(top: 24, left: 0, bottom: 24, right: 0),
      child: Column(children: [
        VFoldersWidget(),
        VFiltersWidget(),
      ]),
    );
  }
}
