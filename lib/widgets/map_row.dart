import 'package:flutter/material.dart';
import '../providers/block.dart';

import './map_cell.dart';

class MapRow extends StatelessWidget {
  final List<Block> _row;

  MapRow(this._row);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _row.map((e) => MapCell(e)).toList(),
    );
  }
}