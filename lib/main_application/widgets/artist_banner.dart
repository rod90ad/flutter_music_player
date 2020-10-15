import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';

class ArtistBanner extends StatelessWidget {
  final Animation martinTop;
  final Animation openMusic;
  final SpotifyController controller;

  ArtistBanner(this.martinTop, this.openMusic)
      : controller = Get.find<SpotifyController>();

  get artist => controller.artistOpened.value;
  get music => controller.musicPlaying.value;

  @override
  Widget build(BuildContext context) {
    if (artist.images == null) return Container();
    return Transform.translate(
      offset: Offset(0, -(martinTop.value * Get.height / 2)),
      child: Container(
          alignment: Alignment.bottomCenter,
          width: Get.width * 0.7 + ((Get.width * 0.06) * openMusic.value),
          height: Get.height / 2 + (Get.height / 4 * openMusic.value),
          margin: EdgeInsets.only(
              left: Get.width * 0.15 - (Get.width * 0.03) * openMusic.value),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black, blurRadius: 5)
              ],
              color: Colors.white,
              image: DecorationImage(
                  image: artist.images.isEmpty
                      ? AssetImage("images/vinil.png")
                      : NetworkImage(artist.images.first.url),
                  fit: BoxFit.fitHeight)),
          child: Container(
            width: Get.width * 0.4,
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (openMusic.value >= 0.1)
                  Opacity(
                      opacity: openMusic.value,
                      child: Text(music.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black)
                              ],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black))),
                Text(artist.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Colors.black)
                        ],
                        fontSize: 20 - (openMusic.value * 5),
                        fontWeight: openMusic.value >= 0.1
                            ? FontWeight.normal
                            : FontWeight.bold,
                        decorationColor: Colors.black))
              ],
            ),
          )),
    );
  }
}
