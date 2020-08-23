import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/grid_layout.dart';
import '../widgets/block_progress_bar.dart';
import '../widgets/game_over_dialog.dart';
import '../widgets/game_won_dialog.dart';
import '../widgets/exit_level_dialog.dart';
import '../widgets/remaining_blocks.dart';

import '../providers/grid.dart';
import '../providers/levels.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  showExitLevelDialog() {
    showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black38,
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeIn.transform(animation.value) - 1.0;
        return ExitLevelDialog(curvedValue);
      },
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int nextLevelNumber =
        Provider.of<Levels>(context, listen: false).nextLevelNumber;
    String nextGroup = Provider.of<Levels>(context, listen: false).nextGroup;
    return WillPopScope(
      onWillPop: () async {
        this.showExitLevelDialog();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Platform.isAndroid
                            ? Icon(Icons.arrow_back)
                            : Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          this.showExitLevelDialog();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Level ${Provider.of<Levels>(context, listen: false).currentLevelNumber}",
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        Provider.of<Levels>(context, listen: false)
                            .currentGroup,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  BlocksProgressBar(),
                  RemainingBlocks(),
                  GridLayout(),
                ],
              ),
            ),
            Consumer<Grid>(
              builder: (context, grid, child) =>
                  grid.isGameOver ? GameOverDialog() : SizedBox(),
            ),
            Consumer<Grid>(
              builder: (context, grid, child) => grid.isGameWon
                  ? GameWonDialog(nextLevelNumber, nextGroup)
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
