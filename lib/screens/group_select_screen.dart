import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/groups_list.dart';

import './main_screen.dart';

class GroupSelectScreen extends StatelessWidget {
  static const routeName = '/groupName';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Platform.isAndroid
                      ? Icon(Icons.arrow_back)
                      : Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        MainScreen.routeName, (route) => false);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Levels',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: GroupsList(),
            ),
          ],
        ),
      ),
    );
  }
}
