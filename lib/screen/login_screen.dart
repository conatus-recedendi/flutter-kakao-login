/*
**  lib/screen/login_screen.dart
**
**  This is for view of screen and login control.
**   
**  create by kylee
*/

import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/screen/main_screen.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  bool _isKakaoTalkInstalled = false;

  @override
  void initState() {
    super.initState();
    _initKakaoInstalled();
  }

  @override
  Widget build(BuildContext context) {
    // your clientId can set by the following site.
    // https://developers.kakao.com/docs/latest/ko/getting-started/sdk-android-v1#key-hash
    KakaoContext.clientId =
        "<native-app-key>; // Should not be commmited!

    return Scaffold(
      appBar: AppBar(
        title: Text('Login with KaKao'),
        actions: [],
      ),
      body: Center(
        child: TextButton(
          child: Image(
            image: AssetImage("images/kakao_login_medium_narrow.png"),
          ),
          onPressed: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
        ),
      ),
    );
  }

  _initKakaoInstalled() async {
    // check that kakaotalk application is installed
    try {
      final installed = await isKakaoTalkInstalled();
      setState(() {
        _isKakaoTalkInstalled = installed;
      });
    } on KakaoAuthException catch (e) {
      print(e);
    } on KakaoClientException catch (e) {
      print(e);
    }
    // If the token exists, skip the login process.
    // TODO: The case that token.refreshToken exists but accessToken is missing
    // TODO: occurs. I didn't consider this, so it has some unintentional
    // TODO: behaviors.
    /*
    try {
      var token = await AccessTokenStore.instance.fromStore();
      print(token.refreshToken);
      if (token.refreshToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    */
  }

  _issueAccessToken(String authCode) async {
    // get access token from kakao API request
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      _route();
    } catch (e) {
      print(e); // for error
    }
  }

  _route() {
    // move to the main screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  _loginWithKakao() async {
    // login request with kakao web API
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e); // for error
    }
  }

  _loginWithTalk() async {
    // login request with kakaoTalk API
    // TODO: it wasn't tested.
    try {
      var authCode = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(authCode);
    } catch (e) {
      print(e); // for error
    }
  }
}
