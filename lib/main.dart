/*
**  lib/main.dart
**
**  create by kylee
*/

import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/screen/loding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kakao login demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LodingScreen(),
    );
  }
}
