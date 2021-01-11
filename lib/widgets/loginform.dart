import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freeshowtv/repository/user.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:freeshowtv/screens/home_screen.dart';

class Loginform extends StatefulWidget {
  const Loginform() : super();

  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  _LoginformState();
  final emailField = TextEditingController();
  final passField = TextEditingController();
  final UserRepository _repository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    emailField.dispose();
    passField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.25,
                child: Image.asset('assets/fre.png'),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: emailField,
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Style.Colors.white,
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: passField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Style.Colors.white,
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forget password?',
                      style:
                          TextStyle(color: Style.Colors.white, fontSize: Style.FontSizes.size12),
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      color: Style.Colors.green,
                      onPressed: () async {
                        final res = await _repository.login(
                            emailField.text, passField.text);
                        if (res == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));

                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Login'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('Login Successfull'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Login'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('Login error'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {},
                child: Text.rich(
                  TextSpan(
                      text: 'Don\'t have an account ? ',
                      style: TextStyle(color: Style.Colors.white),
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(color: Style.Colors.green),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
