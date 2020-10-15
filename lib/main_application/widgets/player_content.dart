import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';

class PlayerContent extends StatefulWidget {
  final Animation _playerMargim;

  PlayerContent(this._playerMargim);

  @override
  _PlayerContentState createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation closePlayer;
  PlayerController playerController = Get.find<PlayerController>();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    closePlayer =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController);
    playerController.setAnimationController(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, getMargin()),
        child: Container(
            height: Get.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              //border: Border(top: BorderSide(color: Colors.black))
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                    opacity: widget._playerMargim.value,
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Entypo.shuffle,
                            size: 15 + (widget._playerMargim.value * 5)),
                        onPressed: () {
                          print("shuffle");
                        }),
                    IconButton(
                        icon: Icon(Entypo.fast_backward,
                            size: 15 + (widget._playerMargim.value * 5)),
                        onPressed: () {
                          print("back");
                        }),
                    Container(
                      width: 40 + (widget._playerMargim.value * 15),
                      height: 40 + (widget._playerMargim.value * 15),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Obx(() => IconButton(
                          icon: Icon(
                            playerController.playing.value
                                ? Entypo.pause
                                : Entypo.play,
                            size: 20 + (widget._playerMargim.value * 5),
                            color: Colors.white,
                          ),
                          onPressed: () => playerController.playing.value
                              ? playerController.pause()
                              : playerController.play())),
                    ),
                    IconButton(
                        icon: Icon(Entypo.fast_forward,
                            size: 15 + (widget._playerMargim.value * 5)),
                        onPressed: () {
                          print("forward");
                        }),
                    IconButton(
                        icon: Icon(Icons.repeat,
                            size: 15 + (widget._playerMargim.value * 5)),
                        onPressed: () {
                          print("repeat");
                        }),
                  ],
                )
              ],
            )));
  }

  double getMargin() {
    return (Get.height * 0.9) +
        (Get.height * 0.2) * closePlayer.value -
        (widget._playerMargim.value * 30);
  }
}
