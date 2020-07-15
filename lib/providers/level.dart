import 'package:flutter/material.dart';
import './block.dart';

class LevelDimensions {
  final int _rows;
  final int _columns;

  LevelDimensions(this._rows, this._columns);

  int get rows {
    return this._rows;
  }

  int get columns {
    return this._columns;
  }
}

class Level with ChangeNotifier{
  LevelDimensions _levelDimensions = LevelDimensions(0, 0);
  List<Block> _enemies = List();

  Level(this._levelDimensions);

  LevelDimensions get levelDimensions {
    return this._levelDimensions;
  }

  List<Block> get enemies{
    return this._enemies;
  }
}
