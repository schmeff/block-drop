import 'package:flutter/material.dart';

import 'dart:async';

import './game_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
