import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _storedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
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
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Profile"),
      ),
      body: Column(
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
          FlatButton(
            onPressed: _takePicture,
            child: Text("Change Profile Picture"),
          )
        ],
      ),
    );
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
}