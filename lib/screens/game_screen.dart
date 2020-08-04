import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/grid_layout.dart';
import '../widgets/block_progress_bar.dart';
import '../widgets/game_over_dialog.dart';

import '../providers/grid.dart';
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
        Provider.of<Grid>(context, listen: false).clearGrid();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Level ${Provider.of<Levels>(context, listen: false).currentLevelNumber}",
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
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
                          Consumer<Grid>(
                            builder: (context, grid, child) => Container(
                              margin: EdgeInsets.only(right: 35),
                              child: Text(
                                "x ${grid.blockCount.toString()}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GridLayout(),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<Grid>(
              builder: (context, grid, child) =>
                  grid.isGameOver ? GameOverDialog() : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
