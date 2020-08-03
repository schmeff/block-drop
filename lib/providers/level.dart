import 'dart:convert';

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

  Map toJson() => {'rows': this._rows, 'columns': this._columns};
}

class Level with ChangeNotifier {
  final int _number;
  final LevelDimensions _levelDimensions;
  final List<Block> _enemies;
  final int _blockCount;
  final Map<String, int> _stars;

  Level(this._number, this._levelDimensions, this._enemies, this._blockCount,
      this._stars);

  Map toJson() => {
        'number': this._number,
        'levelDimensions': this._levelDimensions != null
            ? this._levelDimensions.toJson()
            : null,
        'enemies': this._enemies != null
            ? this._enemies.map((e) => e.toJson()).toList()
            : null,
        'blockCount': this._blockCount,
        'stars': this._stars,
      };

  int get number {
    return this._number;
  }

  LevelDimensions get levelDimensions {
    return this._levelDimensions;
  }

  List<Block> get enemies {
    return this._enemies;
  }

  int get blockCount {
    return this._blockCount;
  }

  Map<String, int> get stars {
    return this._stars;
  }
}
