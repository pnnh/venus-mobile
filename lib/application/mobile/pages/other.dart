import 'package:flutter/material.dart';

import '../components/work_group.dart';

/// The hove page which hosts the calendar
class OtherPage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const OtherPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: Row(children: [
              Container(
                  width: 56,
                  padding: const EdgeInsets.only(top: 8),
                  color: const Color.fromRGBO(242, 246, 255, 100),
                  child: const WorkGroupWidget()),
              const Expanded(child: Text("其它页面"))
            ]))
          ],
        ));
  }
}
