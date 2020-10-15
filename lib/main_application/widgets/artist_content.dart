import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/main_application/widgets/song_list.dart';
import 'package:spotify/spotify.dart';

class ArtistContent extends StatelessWidget {
  final Animation fadeIn;
  final Animation fadeOut;
  final List<Track> topSongs;

  ArtistContent(this.fadeIn, this.fadeOut)
      : topSongs = Get.find<SpotifyController>().topSongs;

  @override
  Widget build(BuildContext context) {
    if (fadeIn.value <= 0.2) {
      return IgnorePointer(child: _buildWidget(context));
    } else if (fadeOut.value <= 0.2) {
      return IgnorePointer(child: _buildWidget(context));
    } else {
      return _buildWidget(context);
    }
  }

  Widget _buildWidget(BuildContext context) {
    return Opacity(
      opacity: fadeIn.value == 1 ? fadeOut.value : fadeIn.value,
      child: Container(
        width: Get.width,
        //height: Get.height * 0.4,
        margin: EdgeInsets.only(left: 30, right: 30, top: Get.height / 2.1),
        padding: EdgeInsets.only(top: 30),
        child: Wrap(
          children: [TrackList(topSongs)],
        ),
      ),
    );
  }
}
