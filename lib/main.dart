import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/game_screen.dart';

import 'providers/map.dart';
import 'providers/level.dart';

void main() {
  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => Level(
          LevelDimensions(10, 10),
        ),
      ),
      ChangeNotifierProvider(
        create: (ctx) => Map(10, 10),
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
      home: GameScreen(),
    );
  }
}
