import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/game_screen.dart';

import '../providers/levels.dart';

class LevelsGridItemUnlocked extends StatelessWidget {
  final Map level;

  LevelsGridItemUnlocked(this.level);

  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        (MediaQuery.of(context).size.width - 80.0) / 5;
    final double containerHeight = containerWidth;
    final double borderWidth = 3.0;
    final double starSize = (containerWidth - (borderWidth * 2) - 10) / 3;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(31, 31, 31, 1),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: borderWidth,
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
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: containerHeight * 0.38,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  level['level'].toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star,
                    size: starSize,
                    color: level['stars'] != null && level['stars'] >= 1
                        ? Color.fromRGBO(207, 255, 4, 1)
                        : Theme.of(context).primaryColorDark),
                Spacer(),
                Icon(Icons.star,
                    size: starSize,
                    color: level['stars'] != null && level['stars'] >= 2
                        ? Color.fromRGBO(207, 255, 4, 1)
                        : Theme.of(context).primaryColorDark),
                Spacer(),
                Icon(
                  Icons.star,
                  size: starSize,
                  color: level['stars'] != null && level['stars'] >= 3
                      ? Color.fromRGBO(207, 255, 4, 1)
                      : Theme.of(context).primaryColorDark,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Provider.of<Levels>(context, listen: false)
            .setCurrentLevelNumber(level['level']);
        Navigator.of(context).pushNamed(GameScreen.routeName);
      },
    );
  }
}
