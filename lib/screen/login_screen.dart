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
    // https://developers.kakao.com/docs/latest/ko/getting-started/sdk-android-v1#key-hash
    KakaoContext.clientId = "<native-app-key>"; // Should not be commmited!

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
    // Check users token
    // If the token exists, skip the login process.
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
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      print(e); // for error
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e); // for error
    }
  }

  _loginWithTalk() async {
    try {
      var authCode = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(authCode);
    } catch (e) {
      print(e); // for error
    }
  }
}
