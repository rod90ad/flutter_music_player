import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';

class SearchBar extends StatelessWidget {
  final Animation _animation;
  final Animation _searchBarHorizontalSize;
  final TextEditingController _textController;

  SearchBar(
      this._animation, this._searchBarHorizontalSize, this._textController);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.88;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: (_animation.value + 0.01) * height,
            horizontal: (_searchBarHorizontalSize.value * 100) + 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
          controller: _textController,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 11, top: 4),
              icon: Icon(Icons.person_search_sharp, color: Colors.black),
              labelText: "Artist",
              labelStyle: TextStyle(color: Colors.black)),
          style: TextStyle(color: Colors.black),
          onFieldSubmitted: (value) =>
              Get.find<SpotifyController>().searchArtist(value),
        ),
      ),
    );
  }
}
