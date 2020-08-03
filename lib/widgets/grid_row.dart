import 'package:flutter/material.dart';
import '../providers/block.dart';

import 'grid_cell.dart';

class GridRow extends StatelessWidget {
  final List<Block> _row;

  GridRow(this._row);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _row.map((e) => GridCell(e)).toList(),
    );
  }
}
