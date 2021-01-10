import 'package:flutter/material.dart';
import 'package:movietracker/screens/profile_screen.dart';
import 'package:movietracker/screens/search_screen.dart';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:movietracker/screens/login_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Style.Colors
              .mainColorLighter, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 60.0,
              child: DrawerHeader(
                  child: Container(
                    child: Text(
                      "Menu",
                      style: TextStyle(color: Style.Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  decoration: BoxDecoration(color: Style.Colors.mainColor),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
            ),
            ListTile(
              title: Container(
                child: Text(
                  "Search",
                  style: TextStyle(color: Style.Colors.white),
                ),
                alignment: Alignment.centerLeft,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
            ListTile(
              title: Container(
                child: Text(
                  "My Profile",
                  style: TextStyle(color: Style.Colors.white),
                ),
                alignment: Alignment.centerLeft,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              title: Container(
                child: Text(
                  "Search",
                  style: TextStyle(color: Style.Colors.white),
                ),
                alignment: Alignment.centerLeft,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        )));
  }
}
