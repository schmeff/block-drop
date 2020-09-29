import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grid.dart';
import '../providers/block.dart';

import 'grid_row.dart';

class GridLayout extends StatelessWidget {
  List<Widget> mapRows(List<List<Block>> map, double mapHeight) {
    return map
        .map(
          (e) => SizedBox(
            height: mapHeight / map.length,
            child: GridRow(e),
          ),
        )
        .toList();
  }

  double calculateGridHeight(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return deviceHeight / 2 > deviceWidth * 0.95
        ? deviceWidth * 0.95
        : deviceHeight / 2;
  }

  @override
  Widget build(BuildContext context) {
    var grid = Provider.of<Grid>(context).grid;
    var gridHeight = calculateGridHeight(context);
    var gridWidth = gridHeight;
    return Container(
      height: gridHeight + 1,
      width: gridWidth,
      child: Column(
        children: mapRows(grid, gridHeight),
      ),
    );
  }
}
