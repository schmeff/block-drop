import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/game_screen.dart';

import '../providers/levels.dart';

class LevelsGridItem extends StatelessWidget {
  final int levelNumber;

  LevelsGridItem(this.levelNumber);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          levelNumber.toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      onTap: () {
        Provider.of<Levels>(context, listen: false)
            .setCurrentLevelNumber(this.levelNumber);
        Navigator.of(context).pushNamed(GameScreen.routeName);
      },
    );
  }
}
