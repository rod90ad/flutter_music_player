import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/main_application/stagger_animation.dart';

class MainApplication extends StatefulWidget {
  @override
  MainApplicationState createState() => MainApplicationState();
}

class MainApplicationState extends State<MainApplication>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  SpotifyController spotifyController;
  PlayerController playerController;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    animationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    spotifyController = Get.put(SpotifyController(this));
    playerController = Get.put(PlayerController(this));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   spotifyController.stateController(To.back);
      // }),
      body: StaggerAnimation(
          controller: animationController,
          spotifyController: spotifyController,
          playerController: playerController,
          textEditingController: textEditingController),
    );
  }
}
