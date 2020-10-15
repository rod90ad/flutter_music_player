import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyAuth extends StatefulWidget {
  final Uri authUri;
  final String redirectUri;

  SpotifyAuth(this.authUri, this.redirectUri);

  @override
  _SpotifyAuthState createState() => _SpotifyAuthState();
}

class _SpotifyAuthState extends State<SpotifyAuth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: widget.authUri.toString(),
      navigationDelegate: (navReq) {
        if (navReq.url.startsWith(widget.redirectUri)) {
          Navigator.of(context).pop(navReq.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ));
  }
}
