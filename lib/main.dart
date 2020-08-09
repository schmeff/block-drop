import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/game_screen.dart';
import './screens/level_select_screen.dart';
import './screens/group_select_screen.dart';
import './screens/loading_screen.dart';
import './screens/main_screen.dart';

import 'providers/grid.dart';
import './providers/levels.dart';

void main() {
  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => Levels(),
      ),
      ChangeNotifierProxyProvider<Levels, Grid>(
        create: (ctx) => Grid(null, null, null),
        update: (ctx, levels, map) => Grid(
            levels.getLevel(levels.currentGroup, levels.currentLevelNumber),
            levels.currentGroup,
            levels.currentLevelNumber),
      ),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Game',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
      routes: {
        LevelSelectScreen.routeName: (ctx) => LevelSelectScreen(),
        GroupSelectScreen.routeName: (ctx) => GroupSelectScreen(),
        GameScreen.routeName: (ctx) => GameScreen(),
        LoadingScreen.routeName: (ctx) => LoadingScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}
