import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

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

    Provider.of<Levels>(context, listen: false).setCurrentLevelNumber(
        Provider.of<Levels>(context, listen: false).currentLevelNumber);
    Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
      ),
    );
  }
}
