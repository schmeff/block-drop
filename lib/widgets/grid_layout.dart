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

  @override
  Widget build(BuildContext context) {
    var grid = Provider.of<Grid>(context).grid;
    var gridHeight = MediaQuery.of(context).size.height / 2;
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
