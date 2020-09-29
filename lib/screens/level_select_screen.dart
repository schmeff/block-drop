import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import '../providers/levels.dart';

import '../widgets/levels_grid.dart';

import '../screens/group_select_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  static const routeName = '/level-select';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            GroupSelectScreen.routeName, (route) => false);
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Platform.isAndroid
                        ? Icon(Icons.arrow_back)
                        : Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          GroupSelectScreen.routeName, (route) => false);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${Provider.of<Levels>(context, listen: false).currentGroup}',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            LevelsGrid(),
          ],
        ),
      ),
    );
  }
}
