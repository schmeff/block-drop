import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grid.dart';

import '../screens/level_select_screen.dart';

class ExitLevelDialog extends StatefulWidget {
  final _curvedValue;

  ExitLevelDialog(this._curvedValue);

  @override
  _ExitLevelDialogState createState() => _ExitLevelDialogState();
}

class _ExitLevelDialogState extends State<ExitLevelDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0.0, widget._curvedValue * 200, 0.0),
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
                      'Quit Level?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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
                            Provider.of<Grid>(context, listen: false)
                                .clearGrid();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LevelSelectScreen.routeName, (route) => false);
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
                                  'Quit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
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
                                  'Keep Playing',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
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
  }
}
