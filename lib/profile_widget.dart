import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:developer' as developer;

class Profile extends StatefulWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text('Profile page'),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _ProfilePicture();
  }
}

class _ProfilePicture extends State<Profile> {
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
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Image(
            image: _storedImage == null
                ? NetworkImage(
                'https://pwcenter.org/sites/default/files/styles/profile_image/public/default_images/default_profile.png?itok=wW1obErD')
                : FileImage(_storedImage),
            fit: BoxFit.cover,
            width: 250,
            height: 250,
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
