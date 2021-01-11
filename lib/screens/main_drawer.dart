import 'package:flutter/material.dart';
import 'package:freeshowtv/screens/profile_screen.dart';
import 'package:freeshowtv/screens/search_screen.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:freeshowtv/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freeshowtv/repository/user.dart';
import 'package:freeshowtv/screens/home_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool _isConnect;
  final UserRepository _repository = UserRepository();

  Future<Null> getloginStatus() async {
    final db = await SharedPreferences.getInstance();
    final sessionId = db.getString('sessionId') ?? null;
    if (sessionId != null) {
      setState(() {
        _isConnect = true;
      });
    } else {
      setState(() {
        _isConnect = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isConnect = false;
    getloginStatus();
  }

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
              onTap: _isConnect
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    }
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
            ),
            ListTile(
                title: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      RaisedButton(
                        color:
                            _isConnect ? Style.Colors.red : Style.Colors.green,
                        onPressed: _isConnect
                            ? () {
                                _repository.logout();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                        child: Text(_isConnect ? "Log out" : "Log In",
                            style: TextStyle(fontSize: Style.FontSizes.size20)),
                      ),
                    ],
                  ),
                ),
                onTap: _isConnect
                    ? () {
                        _repository.logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }),
          ],
        )));
  }
}
