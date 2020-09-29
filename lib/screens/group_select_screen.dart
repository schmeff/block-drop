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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
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
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.17,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Levels',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
