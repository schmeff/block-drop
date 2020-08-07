import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

import './levels_grid_item.dart';

class LevelsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Levels>(context).levels,
      builder: (ctx, levelsSnapshot) => levelsSnapshot.hasData
          ? GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(20.0),
              children: levelsSnapshot.data
                  .map<Widget>((levelNumber) => LevelsGridItem(levelNumber))
                  .toList(),
            )
          : Container(),
    );
  }
}
