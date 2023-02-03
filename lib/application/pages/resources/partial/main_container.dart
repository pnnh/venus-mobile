import 'package:flutter/material.dart';

class MainContainer extends StatefulWidget {
  final Widget child;

  const MainContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 1200,
          //height: 1024,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: widget.child),
    );
  }
}
