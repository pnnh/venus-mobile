import 'package:dream/application/desktop/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'avatar.dart';

class WorkGroupWidget extends StatefulWidget {
  const WorkGroupWidget({Key? key}) : super(key: key);

  @override
  State<WorkGroupWidget> createState() => _WorkGroupWidget();
}

class _WorkGroupWidget extends State<WorkGroupWidget> {
  final Color selectedColor = const Color.fromRGBO(0, 119, 212, 100);
  final Color defaultColor = const Color.fromRGBO(146, 148, 152, 100);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = DesktopRouterDelegate.of(context);
    debugPrint("work_group ${routerDelegate.currentConfiguration.uri}");
    return Column(children: [
      const AvatarWidget(),
      const SizedBox(height: 24),
      IconButton(
          icon: SvgPicture.asset(
            "static/images/icons/todo.svg",
            color: routerDelegate.currentConfiguration.uri.path ==
                    DesktopRoutePath.home().uri.path
                ? selectedColor
                : defaultColor,
          ),
          iconSize: 24,
          onPressed: () {
            routerDelegate.go("/");
          }),
      const SizedBox(height: 24),
      IconButton(
          icon: SvgPicture.asset(
            "static/images/icons/booklet.svg",
            color: routerDelegate.currentConfiguration.uri.path ==
                    DesktopRoutePath.calendar().uri.path
                ? selectedColor
                : defaultColor,
          ),
          iconSize: 24,
          onPressed: () {
            routerDelegate.go("/calendar");
          }),
      const SizedBox(height: 24),
      IconButton(
          icon: SvgPicture.asset(
            "static/images/icons/todo.svg",
            color: routerDelegate.currentConfiguration.uri.path ==
                    DesktopRoutePath.other().uri.path
                ? selectedColor
                : defaultColor,
          ),
          iconSize: 24,
          onPressed: () {
            routerDelegate.go("/other");
          }),
    ]);
  }
}
