import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/block.dart';
import '../providers/grid.dart';

class GridCell extends StatelessWidget {
  final Block _block;

  GridCell(this._block);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          Provider.of<Grid>(context, listen: false)
              .dropBlock(_block.position.column);
          Provider.of<Grid>(context, listen: false)
              .unHighlightColumn(_block.position.column);
          Provider.of<Grid>(context, listen: false)
              .setCurrentlyHighlightedColumn(null);
        },
        onTapDown: (details) {
          Provider.of<Grid>(context, listen: false)
              .highlightColumn(_block.position.column);
          Provider.of<Grid>(context, listen: false)
              .setCurrentlyHighlightedColumn(_block.position.column);
        },
        onTapCancel: () {
          Provider.of<Grid>(context, listen: false)
              .unHighlightColumn(_block.position.column);
          Provider.of<Grid>(context, listen: false)
              .setCurrentlyHighlightedColumn(null);
        },
        child: Container(
          margin: EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            color: !_block.highlighted
                ? _block.color
                : _block.color.withOpacity(0.7),
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
