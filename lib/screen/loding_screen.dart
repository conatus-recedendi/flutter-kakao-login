import 'package:flutter/material.dart';
import 'dart:async';
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
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
