import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = '/splash_screen_page';
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, HomePage.routeName)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/restaurant-icon.png', width: 50, height: 50),
          SizedBox(height: 8.0),
          Text('Loading...')
        ],
      )),
    );
  }
}
