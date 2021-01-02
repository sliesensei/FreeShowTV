import 'package:flutter/material.dart';
import 'package:movietracker/style/theme.dart' as Style;

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("Hello"),
          decoration: BoxDecoration(color: Style.Colors.mainColor),
        ),
        ListTile(title: Text("1")),
        ListTile(title: Text("2")),
        ListTile(title: Text("3")),
        ListTile(title: Text("4")),
      ],
    ));
  }
}
