import 'package:flutter/material.dart';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:movietracker/screens/login_screen.dart';

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
        ListTile(
          title: Text("Account detail"),
          onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen()));
                  // do something
                },
              ),
        ListTile(title: Text("2")),
        ListTile(title: Text("3")),
        ListTile(title: Text("4")),
      ],
    ));
  }
}
