import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/level_select_screen.dart';

import '../providers/levels.dart';
import '../providers/grid.dart';

class GameOverDialog extends StatefulWidget {
  @override
  _GameOverDialogState createState() => _GameOverDialogState();
}

class _GameOverDialogState extends State<GameOverDialog> {
  void showGameOverDialog() {
    showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black38,
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeIn.transform(animation.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 5.0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 250,
                width: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Out of Blocks',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                print('watch ad');
                              },
                              enableFeedback: true,
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Get more Blocks  ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                      Icons.play_circle_outline,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushReplacementNamed(
                                //     LoadingScreen.routeName);
                                Provider.of<Grid>(context, listen: false)
                                    .clearGrid();
                                Provider.of<Grid>(context, listen: false)
                                    .setIsGameOver(false);
                                Provider.of<Levels>(context, listen: false)
                                    .setCurrentLevelNumber(Provider.of<Levels>(
                                            context,
                                            listen: false)
                                        .currentLevelNumber);
                                Navigator.of(context).pop();
                              },
                              enableFeedback: true,
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Restart',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LevelSelectScreen.routeName);
                              },
                              enableFeedback: true,
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Level Selection',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {},
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 500), () => showGameOverDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
