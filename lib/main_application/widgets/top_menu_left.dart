import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/enums/to.dart';

class TopMenuLeft extends StatelessWidget {
  final Animation marginLeft;

  TopMenuLeft(this.marginLeft);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-40 * marginLeft.value, 10),
      child: IconButton(
          onPressed: () {
            Get.find<SpotifyController>().stateController(To.back);
          },
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 33)),
    );
  }
}
