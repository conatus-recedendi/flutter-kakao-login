/*
**  lib/screen/loding_screen.dart
**
**  This is for Splash Screen.
**  create by kylee
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/screen/login_screen.dart';

class LodingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LodingScreen();
  }
}

class _LodingScreen extends State<LodingScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    // wait a few seconds.
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    // move to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // struct of loding screen
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
