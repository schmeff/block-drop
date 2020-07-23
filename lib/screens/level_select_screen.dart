import 'package:flutter/material.dart';

import '../widgets/levels_grid.dart';

class LevelSelectScreen extends StatelessWidget {
  static const routeName = '/level-select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LevelsGrid()
    );
  }
}
