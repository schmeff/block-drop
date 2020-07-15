import 'package:flutter/material.dart';

import '../widgets/map_layout.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var sliderVal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Level 1",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            MapLayout(),
          ],
        ),
      ),
    );
  }
}
