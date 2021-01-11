import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freeshowtv/model/account_response.dart';
import 'package:freeshowtv/repository/user.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _storedImage;
  AccountResponse _info;
  String _username;
  String _includeAdult;

  final UserRepository _repository = UserRepository();

  Future<Null> getData() async {
    final data = await _repository.getProfilInfo();
    setState(() {
      _info = data;
      _username = data.username;
      _includeAdult = data.includeAdult;
    });
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final prefs = await SharedPreferences.getInstance();
    await imageFile.copy('${appDir.path}/$fileName');
    prefs.setString('profilePicturePath', '${appDir.path}/$fileName');
  }

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncInitState();
    });
  }

  _asyncInitState() async {
    final prefs = await SharedPreferences.getInstance();
    final profilePicturePath = prefs.getString("profilePicturePath") ?? null;
    if (profilePicturePath != null) {
      setState(() {
        _storedImage = File(profilePicturePath);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_info);
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Profile"),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: _storedImage == null
                      ? NetworkImage(
                          'https://pwcenter.org/sites/default/files/styles/profile_image/public/default_images/default_profile.png?itok=wW1obErD')
                      : FileImage(_storedImage),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
              RaisedButton(
                  child: Text('Change Profile Picture'),
                  color: Style.Colors.green,
                  onPressed: _takePicture),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Utilisateur : ",
                    style: TextStyle(color: Style.Colors.titleColor),
                  ),
                  Text(
                    "$_username",
                    style: TextStyle(color: Style.Colors.white),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Include Adult Content : ",
                      style: TextStyle(color: Style.Colors.titleColor),
                    ),
                    Text(
                      _includeAdult == true ? "Yes" : "No",
                      style: TextStyle(color: Style.Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
