import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/block.dart';
import '../providers/map.dart';

class MapCell extends StatelessWidget {
  final Block _block;

  MapCell(this._block);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          Provider.of<Map>(context, listen: false).dropBlock(_block.position.column);
        },
        child: Container(
          margin: EdgeInsets.all(0.5),
          color: _block.color,
        ),
      ),
    );
  }
}
