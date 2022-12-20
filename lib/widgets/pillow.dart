import 'package:flutter/material.dart';
import 'package:flutter/services.dart';import 'package:pillow/pillow.dart';

class PillowWidget extends StatefulWidget {
  const PillowWidget({Key? key}) : super(key: key);

  @override
  _PillowState createState() => _PillowState();
}

/// State for MyApp
class _PillowState extends State<PillowWidget> {

  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Pillow.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("系统版本 $_platformVersion");
  }
}
