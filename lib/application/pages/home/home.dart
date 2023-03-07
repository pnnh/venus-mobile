import 'package:flutter/material.dart';
import 'package:venus/application/pages/folders/folders.dart';
import 'package:venus/application/pages/tools/tools.dart';
import 'package:venus/services/picture.dart';
import 'package:venus/utils/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeBody(),
    FoldersBody(),
    ToolsBody()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venus"),
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '照片',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '相册',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '工具',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    logger.d("点击了底部导航栏 $index");
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Center(
              child: Text("已获取到权限"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: requestPermission());
  }
}
