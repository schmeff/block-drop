import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/map_layout.dart';
import '../widgets/block_progress_bar.dart';

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
          margin: EdgeInsets.symmetric(vertical: 40),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Level ${Provider.of<Levels>(context, listen: false).currentLevelNumber}",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
              ),
              BlocksProgressBar(),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(2.0),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                      ),
                      Consumer<Map>(
                        builder: (context, map, child) => Container(
                          margin: EdgeInsets.only(right: 35),
                          child: Text(
                            "x ${map.blockCount.toString()}",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MapLayout(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
