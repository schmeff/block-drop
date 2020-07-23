import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/game_screen.dart';
import './screens/level_select_screen.dart';

import './providers/map.dart';
import './providers/levels.dart';

void main() {
  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => Levels(),
      ),
      ChangeNotifierProxyProvider<Levels, Map>(
        create: (ctx) => Map(null),
        update: (ctx, levels, map) =>
            Map(levels.getLevel(levels.currentLevelNumber)),
      ),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LevelSelectScreen(),
      routes: {
        LevelSelectScreen.routeName: (ctx) => LevelSelectScreen(),
        GameScreen.routeName: (ctx) => GameScreen(),
      },
    );
  }
}
