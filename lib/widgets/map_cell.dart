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
          Provider.of<Map>(context, listen: false)
              .dropBlock(_block.position.column);
        },
        child: Container(
          margin: EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            color: _block.color,
            borderRadius: BorderRadius.circular(2.0),
            boxShadow: _block.color != Color.fromRGBO(31, 31, 31, 1)
                ? [
                    BoxShadow(
                      color: _block.color,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
