import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/enums/animation_state.dart';
import 'package:music_player/main_application/main_application.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer;
  final MainApplicationState mainApplication;
  AnimationController animationController;

  var playing = false.obs;

  PlayerController(this.mainApplication) : audioPlayer = AudioPlayer();

  void setAnimationController(AnimationController controller) {
    animationController = controller;
    audioPlayer.onPlayerStateChanged.listen((state) {
      print(state);
      switch (state) {
        case AudioPlayerState.COMPLETED:
          playing.call(false);
          break;
        case AudioPlayerState.PAUSED:
          playing.call(false);
          Future.delayed(Duration(seconds: 5), () => stateController());
          break;
        case AudioPlayerState.PLAYING:
          animationController.forward();
          break;
        case AudioPlayerState.STOPPED:
          break;
      }
    });
  }

  void stateController() {
    bool state =
        Get.find<SpotifyController>().state == AnimationState.openMusic;
    if (!playing.value && !state) animationController.reverse();
    update();
  }

  void play({String url}) {
    if (url == null)
      resume();
    else {
      if (audioPlayer.state == AudioPlayerState.PLAYING) audioPlayer.stop();
      audioPlayer.play(url);
      playing.call(true);
    }
  }

  void resume() {
    audioPlayer.resume();
    playing.call(true);
  }

  void pause() {
    audioPlayer.pause();
    playing.call(false);
  }
}
