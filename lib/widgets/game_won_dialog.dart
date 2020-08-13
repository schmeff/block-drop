import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/levels.dart';
import '../providers/grid.dart';

import '../screens/game_screen.dart';

class GameWonDialog extends StatefulWidget {
  final int nextLevelNumber;
  final String nextGroup;

  GameWonDialog(this.nextLevelNumber, this.nextGroup);

  @override
  _GameWonDialogState createState() => _GameWonDialogState();
}

class _GameWonDialogState extends State<GameWonDialog> {
  void showGameWonDialog() {
    var stars = Provider.of<Grid>(context, listen: false).stars;
    var blockCount = Provider.of<Grid>(context, listen: false).blockCount;
    int currentLevelNumber =
        Provider.of<Levels>(context, listen: false).currentLevelNumber;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
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
                        widget.nextLevelNumber != null
                            ? Text(
                                'Level $currentLevelNumber Cleared!',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w500),
                              )
                            : Text(
                                'All Levels Cleared!',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w500),
                              )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 60,
                          color: blockCount >= stars['one']
                              ? Color.fromRGBO(207, 255, 4, 1)
                              : Color.fromRGBO(31, 31, 31, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          size: 60,
                          color: blockCount >= stars['two']
                              ? Color.fromRGBO(207, 255, 4, 1)
                              : Color.fromRGBO(31, 31, 31, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          size: 60,
                          color: blockCount >= stars['three']
                              ? Color.fromRGBO(207, 255, 4, 1)
                              : Color.fromRGBO(31, 31, 31, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.nextLevelNumber != null
                            ? InkWell(
                                onTap: () {
                                  if (widget.nextLevelNumber != null) {
                                    Provider.of<Levels>(context, listen: false)
                                        .setCurrentLevelNumber(
                                            widget.nextLevelNumber);
                                    Provider.of<Grid>(context, listen: false)
                                        .clearGrid();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            GameScreen.routeName,
                                            (route) => false);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Next Level',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : widget.nextGroup != null
                                ? InkWell(
                                    onTap: () {
                                      if (widget.nextGroup != null) {
                                        Provider.of<Levels>(context,
                                                listen: false)
                                            .setCurrentLevelNumber(1);
                                        Provider.of<Levels>(context,
                                                listen: false)
                                            .setCurrentGroup(widget.nextGroup);
                                        Provider.of<Grid>(context,
                                                listen: false)
                                            .clearGrid();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                GameScreen.routeName,
                                                (route) => false);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Play ${widget.nextGroup}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<Grid>(context, listen: false)
                                .clearGrid();
                            Provider.of<Grid>(context, listen: false)
                                .setIsGameOver(false);
                            Provider.of<Levels>(context, listen: false)
                                .setCurrentLevelNumber(
                                    Provider.of<Levels>(context, listen: false)
                                        .currentLevelNumber);
                            Navigator.of(context).pop();
                          },
                          enableFeedback: true,
                          child: Container(
                            height: 40,
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
                                  'Play Again',
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
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return null;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 500), () => showGameWonDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
