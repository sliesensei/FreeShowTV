import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movietracker/repository/user.dart';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:movietracker/screens/home_screen.dart';

class Logoutform extends StatefulWidget {
  const Logoutform() : super();

  @override
  _LogoutformState createState() => _LogoutformState();
}

class _LogoutformState extends State<Logoutform> {
  _LogoutformState();
  final UserRepository _repository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            splashColor: Colors.pinkAccent,
            color: Colors.red,
            child: new Text(
              "Logout",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: () {
              _repository.logout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
