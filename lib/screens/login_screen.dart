import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movietracker/widgets/logoutform.dart';
import 'package:movietracker/widgets/loginform.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isConnect;

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_isConnect == true)
      return Logoutform();
    else {
      return Loginform();
    }
  }
}