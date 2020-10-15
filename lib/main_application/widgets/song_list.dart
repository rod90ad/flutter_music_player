import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:spotify/spotify.dart';

class TrackList extends StatelessWidget {
  final List<Track> tracks;

  TrackList(this.tracks);

  @override
  Widget build(BuildContext context) {
    if (tracks == null || tracks.isEmpty) return Container();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Get.height * 0.4,
      child: ListView(
        children: tracks.map((e) => trackTile(e)).toList(),
      ),
    );
  }

  Widget trackTile(Track track) {
    Duration duration = Duration(milliseconds: track.durationMs);
    return InkWell(
      onTap: () {
        Get.find<SpotifyController>().playMusic(track);
      },
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              track.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            )),
            Container(
                width: 30,
                child:
                    Text(Get.find<SpotifyController>().getDuration(duration)))
          ],
        ),
      ),
    );
  }
}
