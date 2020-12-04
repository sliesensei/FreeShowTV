import 'package:flutter/material.dart';
import 'profile_widget.dart';
import 'home_widget.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavState();
  }
}

class _NavState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Time'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}