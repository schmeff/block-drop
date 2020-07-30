import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/map.dart';
import '../providers/block.dart';

import './map_row.dart';

class MapLayout extends StatelessWidget {
  List<Widget> mapRows(List<List<Block>> map, double mapHeight) {
    return map
        .map(
          (e) => SizedBox(
            height: mapHeight / map.length,
            child: MapRow(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var map = Provider.of<Map>(context).map;
    var mapHeight = MediaQuery.of(context).size.height / 2;
    var mapWidth = mapHeight;
    return Container(
      padding: EdgeInsets.all(0.5),
      height: mapHeight + 1,
      width: mapWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: mapRows(map, mapHeight),
      ),
    );
  }
}
