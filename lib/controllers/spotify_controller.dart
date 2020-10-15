import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/enums/animation_state.dart';
import 'package:music_player/enums/to.dart';
import 'package:music_player/main_application/main_application.dart';
import 'package:music_player/models/artist_model.dart';
import 'package:spotify/spotify.dart';

class SpotifyController extends GetxController {
  SpotifyApi _spotify;
  final MainApplicationState applicationState;
  Uri _authUri;
  var _grant;
  String _responseUri;
  String _redirectUri;

  AnimationState state = AnimationState.searchClear;

  //Obs
  var artistList = List<ArtistModel>().obs;
  var artistOpened = Artist().obs;
  var topSongs = List<Track>().obs;
  var musicPlaying = Track().obs;

  SpotifyController(this.applicationState) {
    SpotifyApiCredentials credentials =
        SpotifyApiCredentials("your_client_id", "your_client_secret");
    _grant = SpotifyApi.authorizationCodeGrant(credentials);
    _redirectUri = 'https://example.com/auth';
    final scopes = ['user-read-email', 'user-library-read'];
    _authUri = _grant.getAuthorizationUrl(
      Uri.parse(_redirectUri),
      scopes: scopes,
    );
    _spotify = SpotifyApi(credentials);
  }

  String getDuration(Duration duration) {
    int min = duration.inMinutes;
    int sec = duration.inSeconds - (60 * duration.inMinutes);
    return "$min:${sec.toString().length == 1 ? '0$sec' : sec}";
  }

  void searchArtist(String artist) async {
    if (artist.isEmpty) {
      stateController(To.back);
      return;
    }
    var search = await _spotify.search
        .get(artist, [SearchType.artist])
        .first(6)
        .catchError((err) => print((err as SpotifyException).message));
    // ignore: invalid_use_of_protected_member
    artistList.value.clear();
    if (search == null) {
      artistList = List<ArtistModel>().obs;
    }
    search.forEach((pages) {
      pages.items.forEach((item) {
        if (item is Artist) {
          // ignore: invalid_use_of_protected_member
          artistList.value.add(ArtistModel(item.id, item.name, item.href,
              item.type, item.uri, _transformImagesInList(item.images)));
        }
      });
    });
    update();
    if (state == AnimationState.searchClear)
      stateController(To.go);
    else
      // ignore: invalid_use_of_protected_member
      applicationState.setState(() {});
  }

  void openArtist(String artistId) async {
    var search = await _spotify.artists
        .get(artistId)
        .catchError((err) => print((err as SpotifyException).message));
    if (search == null) {
      return;
    }
    artistOpened.value = search;
    update();
    topMusicsOfArtist(artistId);
    if (state == AnimationState.searched)
      stateController(To.go);
    else
      // ignore: invalid_use_of_protected_member
      applicationState.setState(() {});
  }

  void topMusicsOfArtist(String artistId) async {
    var search = await _spotify.artists.getTopTracks(artistId, "br");
    topSongs.clear();
    search.forEach((track) {
      topSongs.add(track);
    });
    update();
  }

  void playMusic(Track track) async {
    print(track.isPlayable);
    print(track.previewUrl);
    if (track.previewUrl != null) {
      musicPlaying.call(track);
      Get.find<PlayerController>().play(url: track.previewUrl);
    }
    if (state == AnimationState.openArtist)
      stateController(To.go);
    else
      // ignore: invalid_use_of_protected_member
      applicationState.setState(() {});
  }

  void stateController(To to) {
    switch (state) {
      case AnimationState.searchClear:
        if (to == To.go) {
          state = AnimationState.searchClear_searched;
          applicationState.animationController.forward();
        }
        break;
      case AnimationState.searched:
        if (to == To.go) {
          state = AnimationState.searched_openArtist;
          applicationState.animationController.forward();
        } else {
          state = AnimationState.searched_searchClear;
          applicationState.animationController.reverse();
        }
        break;
      case AnimationState.openArtist:
        if (to == To.go) {
          state = AnimationState.openArtist_openMusic;
          applicationState.animationController.forward();
        } else {
          state = AnimationState.openArtist_searched;
          applicationState.animationController.reverse();
        }
        break;
      case AnimationState.openMusic:
        if (to == To.back) {
          state = AnimationState.openMusic_openArtist;
          applicationState.animationController.reverse();
        }
        break;
      default:
        return;
    }
  }

  List<String> _transformImagesInList(images) {
    List<String> aux = List<String>();
    images.forEach((image) {
      aux.add(image.url);
    });
    return aux;
  }
}
