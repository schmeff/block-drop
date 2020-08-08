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
        decoration: BoxDecoration(
          color: Color.fromRGBO(31, 31, 31, 1),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                offset: Offset(
                  0.0,
                  5.0,
                ),
                blurRadius: 5.0),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              levelNumber.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
