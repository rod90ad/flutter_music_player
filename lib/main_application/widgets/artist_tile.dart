import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/models/artist_model.dart';

class ArtistTile extends StatelessWidget {
  final ArtistModel model;

  ArtistTile(this.model);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: height * 0.08,
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: InkWell(
        onTap: () {
          Get.find<SpotifyController>().openArtist(model.id);
        },
        child: Row(
          children: [
            if (model.images != null && model.images.isNotEmpty)
              SizedBox(
                  width: width * 0.15, child: _discoCapa(model.images.first))
            else
              SizedBox(
                width: width * 0.15,
                child: Image.asset("images/vinil.png"),
              ),
            SizedBox(width: 15),
            Expanded(
                child: Text(model.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)))
          ],
        ),
      ),
    );
  }

  Widget _discoCapa(String img) {
    return Stack(
      children: [
        Transform.translate(
            offset: Offset(18, 4), child: Image.asset("images/vinil.png")),
        Transform.rotate(
            angle: 0.2,
            child: Image.network(model.images.first, width: 60, height: 60)),
      ],
    );
  }
}
