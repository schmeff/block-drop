import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

import '../widgets/levels_grid.dart';

class LevelSelectScreen extends StatelessWidget {
  static const routeName = '/level-select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
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
    );
  }
}
