import 'dart:async';

import 'package:flutter/material.dart';

import './block.dart';
import './level.dart';

class Map with ChangeNotifier {
  List<List<Block>> _map;
  List<Block> _enemies = List();
  int _blockCount;
  int _startingBlockCount;
  List<int> _enemiesToBeRemoved = List();
  int _currentlyHighlightColumn;
  double _blockPercentage = 1.0;

  List<List<Block>> get map {
    return this._map;
  }

  Map(Level level) {
    if (level != null) {
      this._enemies = level.enemies;
      this._startingBlockCount = level.blockCount;
      this._blockCount = this._startingBlockCount;
      if (level.levelDimensions.rows > 0 && level.levelDimensions.columns > 0) {
        _buildMap(level.levelDimensions.rows, level.levelDimensions.columns);
        _placeEnemies();
      }
    }
  }

  void setCurrentlyHighlightedColumn(int column) {
    this._currentlyHighlightColumn = column;
  }

  int get blockCount {
    return this._blockCount;
  }

  _buildMap(int rows, int columns) {
    this._map = List.generate(
        rows,
        (i) => List.generate(
            columns,
            (j) => Block(
                  Position(i, j),
                  BlockStatus.EMPTY,
                  [],
                )));
  }

  _placeEnemies() {
    this._enemies.forEach((enemy) {
      this._map[enemy.position.row][enemy.position.column] = enemy;
    });
    _moveEnemies();
  }

  _markCellAsEmpty(int row, int column) {
    bool high = false;
    if (this._currentlyHighlightColumn == column) {
      high = this._map[row][column].highlighted;
    }
    this._map[row][column] =
        Block(Position(row, column), BlockStatus.EMPTY, []);
    this._map[row][column].setHighlighted(high);
  }

  _markCellAsAlly(int row, int column) {
    bool high = this._map[row][column].highlighted;
    this._map[row][column] =
        Block(Position(row, column), BlockStatus.ALLY, [Direction.DOWN]);
    this._map[row][column].setHighlighted(high);
  }

  _moveEnemies() {
    Timer(Duration(milliseconds: 500), () {
      if (this._enemies.length > 0) {
        this._enemies.forEach((enemy) {
          if (enemy.currentDirection == Direction.LEFT) {
            this._moveEnemyLeft(enemy);
          } else if (enemy.currentDirection == Direction.RIGHT) {
            this._moveEnemyRight(enemy);
          } else if (enemy.currentDirection == Direction.UP) {
            this._moveEnemyUp(enemy);
          } else if (enemy.currentDirection == Direction.DOWN) {
            this._moveEnemyDown(enemy);
          }
          enemy.incrementDirection();
        });
        this
            ._enemiesToBeRemoved
            .forEach((enemyId) => this._removeEnemy(enemyId));
        this._enemiesToBeRemoved.clear();
        _moveEnemies();
        notifyListeners();
      }
    });
  }

  _moveEnemyLeft(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    enemy.setPosition(enemy.position.row, enemy.position.column - 1);
    this._map[enemy.position.row][enemy.position.column] = enemy;
  }

  _moveEnemyRight(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    enemy.setPosition(enemy.position.row, enemy.position.column + 1);
    this._map[enemy.position.row][enemy.position.column] = enemy;
  }

  _moveEnemyUp(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    if (this._map[enemy.position.row - 1][enemy.position.column].status ==
        BlockStatus.ALLY) {
      this._enemiesToBeRemoved.add(enemy.id);
    } else {
      enemy.setPosition(enemy.position.row - 1, enemy.position.column);
      this._map[enemy.position.row][enemy.position.column] = enemy;
    }
  }

  _moveEnemyDown(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    enemy.setPosition(enemy.position.row + 1, enemy.position.column);
    this._map[enemy.position.row][enemy.position.column] = enemy;
  }

  dropBlock(int column) {
    if (this._map[0][column].status == BlockStatus.EMPTY &&
        this._blockCount > 0) {
      this._blockCount -= 1;
      this._calculatePercentageLeft();
      this._map[0][column] =
          Block(Position(0, column), BlockStatus.ALLY, [Direction.DOWN]);
      notifyListeners();
      _queueAllyMove(0, column, Direction.DOWN);
    }
  }

  _queueAllyMove(int row, int column, Direction direction) {
    Timer(Duration(milliseconds: 500), () {
      if (this._map[row][column].status == BlockStatus.ENEMY) {
        return;
      }
      if (direction == Direction.DOWN) {
        _moveAllyDown(row, column);
      }
    });
  }

  _moveAllyDown(int row, int column) {
    if (row >= this._map.length - 1) {
      this._markCellAsEmpty(row, column);
    } else if (this._map[row + 1][column].status == BlockStatus.EMPTY ||
        this._map[row + 1][column].status == BlockStatus.ENEMY) {
      this._markCellAsEmpty(row, column);
      if (this._map[row + 1][column].status == BlockStatus.ENEMY) {
        this._blockCount += 1;
        this._calculatePercentageLeft();
        this._removeEnemy(this._map[row + 1][column].id);
      }
      this._markCellAsAlly(row + 1, column);
      _queueAllyMove(row + 1, column, Direction.DOWN);
    }
    notifyListeners();
  }

  _removeEnemy(int id) {
    this._enemies.removeWhere((enemy) => enemy.id == id);
  }

  clearMap() {
    if (this._enemies.length > 0) {
      this._enemies = [];
    }
  }

  highlightColumn(int column) {
    this._map.forEach((row) {
      row[column].setHighlighted(true);
    });
    notifyListeners();
  }

  unHighlightColumn(int column) {
    this._map.forEach((row) => row[column].setHighlighted(false));
    notifyListeners();
  }

  void _calculatePercentageLeft() {
    this._blockPercentage = this._blockCount / this._startingBlockCount;
  }

  double get blockPercentage {
    return this._blockPercentage;
  }
}
