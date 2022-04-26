import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

String selectedUrl = 'https://flutter.io';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final _urlCtrl = TextEditingController(text: selectedUrl);
  // late StreamSubscription<String> _onUrlChanged;
  final _history = [];
  @override
  void initState() {
    super.initState();

    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on url changed
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        var uri = Uri.parse(url);
        var urlString = uri.toString();
        if (urlString.contains('#access_token=')) {
          var split = urlString.split('#access_token=');
          var accessToken = split[1];
          print('accessToken: $accessToken');
          flutterWebViewPlugin.close();
        }
      }
    });
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: WebviewScaffold(
          url:
              "https://udaiannahelpline.b2clogin.com/udaiannahelpline.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1A_PH_SUSI&client_id=46987fab-6f8c-41ff-9212-149d24c0e21f&nonce=defaultNonce&redirect_uri=msauth%3A%2F%2Fcom.theproindia.UdhayAnna%2FapAFPWAQQ9aDipztY2mWL6jLRmI%253D&scope=openid%20https%3A%2F%2Fudaiannahelpline.onmicrosoft.com%2F2a497828-3f4d-43d0-b9bb-427436878fa7%2Fread&response_type=id_token%20token&prompt=login",
        ),
      ),
    );
  }
}
