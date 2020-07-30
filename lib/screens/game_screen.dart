import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/map_layout.dart';

import '../providers/map.dart';
import '../providers/levels.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<Map>(context, listen: false).clearMap();
        return true;
      },
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(60, 60, 60, 1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Level ${Provider.of<Levels>(context, listen: false).currentLevelNumber}",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Text(Provider.of<Map>(context).blockCount.toString()),
              MapLayout(),
            ],
          ),
        ),
      ),
    );
  }
}
