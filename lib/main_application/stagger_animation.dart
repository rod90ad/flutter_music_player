import 'package:flutter/material.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:music_player/enums/animation_state.dart';
import 'package:music_player/main_application/widgets/artist_list.dart';
import 'package:music_player/main_application/widgets/top_menu_right.dart';

import 'widgets/artist_banner.dart';
import 'widgets/artist_content.dart';
import 'widgets/music_progress.dart';
import 'widgets/player_content.dart';
import 'widgets/top_menu_left.dart';
import 'widgets/search_bar.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final SpotifyController spotifyController;
  final PlayerController playerController;
  final Animation<double> _searchBar;
  final Animation<double> _searchBarHorizontalSize;
  final Animation<double> _artistListFadeIn;
  final Animation<double> _artistListFadeOut;
  final Animation<double> _openArtist;
  final Animation<double> _artistContentFadeIn;
  final Animation<double> _artistContentFadeOut;
  final Animation<double> _openMusic;
  final TextEditingController textEditingController;

  StaggerAnimation(
      {this.controller,
      this.spotifyController,
      this.playerController,
      this.textEditingController,
      Key key})
      : _searchBar = Tween<double>(begin: 0.5, end: 0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.25, curve: Curves.linear))),
        _artistListFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 0.25, curve: Curves.linear))),
        _searchBarHorizontalSize = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.3, 0.5, curve: Curves.linear))),
        _artistListFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.3, 0.5, curve: Curves.linear))),
        _openArtist = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.3, 0.5, curve: Curves.linear))),
        _artistContentFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.3, 0.6, curve: Curves.linear))),
        _artistContentFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.65, 0.8, curve: Curves.linear))),
        _openMusic = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.65, 1, curve: Curves.linear))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    _animationController();
    return Stack(
      children: [
        ArtistList(_artistListFadeIn, _artistListFadeOut),
        SearchBar(
          _searchBar,
          _searchBarHorizontalSize,
          textEditingController,
        ),
        TopMenuLeft(_artistListFadeOut),
        TopMenuRight(_artistListFadeOut),
        ArtistContent(_artistContentFadeIn, _artistContentFadeOut),
        Stack(
          children: [
            ArtistBanner(_openArtist, _openMusic),
            MusicProgress(_openArtist, _openMusic, this.spotifyController),
          ],
        ),
        PlayerContent(_openMusic)
      ],
    );
  }

  void _animationController() {
    switch (spotifyController.state) {
      case AnimationState.searchClear_searched:
        if (_searchBar.value == 0) {
          controller.stop();
          spotifyController.state = AnimationState.searched;
        }
        break;
      case AnimationState.searched_searchClear:
        if (_searchBar.value == 0.5) {
          textEditingController?.clear();
          spotifyController.state = AnimationState.searchClear;
        }
        break;
      case AnimationState.searched_openArtist:
        if (_openArtist.value == 0) {
          controller.stop();
          spotifyController.state = AnimationState.openArtist;
        }
        break;
      case AnimationState.openArtist_searched:
        if (_openArtist.value == 1) {
          controller.stop();
          spotifyController.state = AnimationState.searched;
        }
        break;
      case AnimationState.openArtist_openMusic:
        if (_openMusic.value == 1) {
          spotifyController.state = AnimationState.openMusic;
        }
        break;
      case AnimationState.openMusic_openArtist:
        if (_openMusic.value == 0) {
          controller.stop();
          spotifyController.state = AnimationState.openArtist;
          Future.delayed(
              Duration(seconds: 5), () => playerController.stateController());
        }
        break;
      default:
        return;
    }
  }
}
