import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/game_screen.dart';
import './screens/level_select_screen.dart';
import './screens/loading_screen.dart';

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
        create: (ctx) => Grid(null),
        update: (ctx, levels, map) =>
            Grid(levels.getLevel(levels.currentLevelNumber)),
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
      home: LevelSelectScreen(),
      routes: {
        LevelSelectScreen.routeName: (ctx) => LevelSelectScreen(),
        GameScreen.routeName: (ctx) => GameScreen(),
        LoadingScreen.routeName: (ctx) => LoadingScreen(),
      },
    );
  }
}
