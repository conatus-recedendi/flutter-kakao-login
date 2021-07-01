import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/screen/login_screen.dart';
import 'package:kakao_flutter_sdk/all.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  String _accountEmail = 'None';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    final User user = await UserApi.instance.me();

    setState(() {
      _accountEmail = user.kakaoAccount!.email.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _accountEmail,
              style: TextStyle(fontSize: 32),
            ),
            TextButton(child: Text('Logout'), onPressed: _logout),
          ],
        ),
      ),
    );
  }

  _logout() async {
    try {
      final code = await UserApi.instance.logout();
      print('2342');
      print(code.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print(e);
    }
  }
}
