import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../exceptions/block_exception.dart';

enum Direction { UP, DOWN, LEFT, RIGHT, NONE } // DO NOT CHANGE THE ORDER THESE ARE LISTED IN

enum BlockStatus { ALLY, ENEMY, EMPTY } // DO NOT CHANGE THE ORDER THESE ARE LISTED IN

class Position {
  int _row;
  int _column;

  Position(this._row, this._column);

  int get row {
    return this._row;
  }

  int get column {
    return this._column;
  }

  Map toJson() => {
    'row': this._row,
    'column': this._column
  };
}

class Block {
  int _id;
  Position _position;
  BlockStatus _status;
  List<Direction> _route;
  int _currentDirectionIndex = 0;

  Block(this._position, this._status, this._route, [this._id]) {
    if (this._status == BlockStatus.ENEMY && this._id == null) {
      throw BlockException("Blocks with 'ENEMY' block status must have an id.");
    }
    if (this._status == BlockStatus.ENEMY &&
        !ListEquality().equals(this._route, [Direction.NONE]) &&
        this._route.length < 2) {
      throw BlockException(
          "Enemy route must either be [Direction.None] or have 2 or more directions for block with id ${this._id}.");
    }
    if (this._status == BlockStatus.ALLY &&
        !ListEquality().equals(_route, [Direction.DOWN])) {
      throw BlockException(
          "Blocks with 'ALLY' block status can only have a direction of [Direction.DOWN].");
    }
  }

  Map toJson() => {
    'id': this._id,
    'position': this._position,
    'status': this._status.index,
    'route': this._route.map((e) => e.index).toList()
  };

  int get id {
    return this._id;
  }

  void setId(int id) {
    this._id = id;
  }

  Position get position {
    return this._position;
  }

  void setPosition(int row, int column) {
    this._position = Position(row, column);
  }

  BlockStatus get status {
    return this._status;
  }

  void setStatus(BlockStatus status) {
    this._status = status;
  }

  Direction get currentDirection {
    return this._route[this._currentDirectionIndex];
  }

  void incrementDirection() {
    if (this._currentDirectionIndex >= _route.length) {
      this._currentDirectionIndex = 0;
    }
    this._currentDirectionIndex = this._currentDirectionIndex >= _route.length - 1
        ? 0
        : this._currentDirectionIndex + 1;
  }

  Color get color {
    if (status == BlockStatus.ALLY) return Colors.blue;
    if (status == BlockStatus.ENEMY) return Colors.red;

    return Colors.white;
  }
}
