import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:freeshowtv/style/theme.dart' as Style;

class VideoPlayerScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  VideoPlayerScreen({Key key, @required this.controller}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(controller);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final YoutubePlayerController controller;
  _VideoPlayerScreenState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.black,
        body: Stack(children: <Widget>[
          Center(
            child: YoutubePlayer(controller: controller),
          ),
          Positioned(
              top: 40.0,
              right: 20.0,
              child: IconButton(
                icon: Icon(EvaIcons.closeCircle),
                color: Style.Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ]));
  }
}
