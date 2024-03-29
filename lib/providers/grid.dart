import 'dart:async';

import 'package:flutter/material.dart';

import './block.dart';
import './level.dart';

import '../utility/player_data.dart';

class Grid with ChangeNotifier {
  List<List<Block>> _grid;
  List<Block> _enemies = List();
  List<Block> _barriers = List();
  int _blockCount;
  int _startingBlockCount;
  Map<String, int> _stars;
  List<int> _enemiesToBeRemoved = List();
  int _currentlyHighlightColumn;
  double _blockPercentage;
  bool _isGameOver = false;
  bool _isGameWon = false;
  final String _levelGroup;
  final int _levelNumber;

  List<List<Block>> get grid {
    return this._grid;
  }

  Grid(Level level, this._levelGroup, this._levelNumber) {
    if (level != null) {
      this._enemies = level.enemies;
      this._barriers = level.barriers;
      this._startingBlockCount = level.blockCount;
      this._blockCount = this._startingBlockCount;
      this._stars = level.stars;
      this._blockPercentage = this._blockCount / this._stars['three'];
      if (level.levelDimensions.rows > 0 && level.levelDimensions.columns > 0) {
        _buildGrid(level.levelDimensions.rows, level.levelDimensions.columns);
        _placeEnemies();
        _placeBarriers();
      }
    }
  }

  void setCurrentlyHighlightedColumn(int column) {
    this._currentlyHighlightColumn = column;
  }

  int get blockCount {
    return this._blockCount;
  }

  int get startingBlockCount {
    return this._startingBlockCount;
  }

  Map<String, int> get stars {
    return this._stars;
  }

  bool get isGameWon {
    return this._isGameWon;
  }

  void setIsGameWon(bool isGameWon) {
    this._isGameWon = isGameWon;
    notifyListeners();
  }

  bool get isGameOver {
    return this._isGameOver;
  }

  void setIsGameOver(bool isGameOver) {
    this._isGameOver = isGameOver;
  }

  _buildGrid(int rows, int columns) {
    this._grid = List.generate(
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
      this._grid[enemy.position.row][enemy.position.column] = enemy;
    });
    _moveEnemies();
  }

  _placeBarriers() {
    this._barriers.forEach((barrier) {
      this._grid[barrier.position.row][barrier.position.column] = barrier;
    });
  }

  _markCellAsEmpty(int row, int column) {
    bool high = false;
    if (this._currentlyHighlightColumn == column) {
      high = true;
    }
    this._grid[row][column] =
        Block(Position(row, column), BlockStatus.EMPTY, []);
    this._grid[row][column].setHighlighted(high);
  }

  _markCellAsAlly(int row, int column) {
    bool high = this._grid[row][column].highlighted;
    this._grid[row][column] =
        Block(Position(row, column), BlockStatus.ALLY, [Direction.DOWN]);
    this._grid[row][column].setHighlighted(high);
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
    bool checkForAlly = false;
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    if (this._grid[enemy.position.row][enemy.position.column - 1].status ==
        BlockStatus.ALLY) {
      checkForAlly = true;
    }
    enemy.setPosition(enemy.position.row, enemy.position.column - 1);
    this._grid[enemy.position.row][enemy.position.column] = enemy;
    if (checkForAlly) {
      this._checkForAllyBlocks();
    }
  }

  _moveEnemyRight(Block enemy) {
    bool checkForAlly = false;
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    if (this._grid[enemy.position.row][enemy.position.column + 1].status ==
        BlockStatus.ALLY) {
      checkForAlly = true;
    }
    enemy.setPosition(enemy.position.row, enemy.position.column + 1);
    this._grid[enemy.position.row][enemy.position.column] = enemy;
    if (checkForAlly) {
      this._checkForAllyBlocks();
    }
  }

  _moveEnemyUp(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    if (this._grid[enemy.position.row - 1][enemy.position.column].status ==
        BlockStatus.ALLY) {
      this._enemiesToBeRemoved.add(enemy.id);
      this._blockCount += 1;
      this._calculatePercentageLeft();
    } else {
      enemy.setPosition(enemy.position.row - 1, enemy.position.column);
      this._grid[enemy.position.row][enemy.position.column] = enemy;
    }
  }

  _moveEnemyDown(Block enemy) {
    _markCellAsEmpty(enemy.position.row, enemy.position.column);
    enemy.setPosition(enemy.position.row + 1, enemy.position.column);
    this._grid[enemy.position.row][enemy.position.column] = enemy;
  }

  dropBlock(int column) {
    if (this._grid[0][column].status == BlockStatus.EMPTY &&
        this._blockCount > 0 &&
        !this._isGameWon) {
      this._blockCount -= 1;
      this._calculatePercentageLeft();
      this._grid[0][column] =
          Block(Position(0, column), BlockStatus.ALLY, [Direction.DOWN]);
      notifyListeners();
      _queueAllyMove(0, column, Direction.DOWN);
    }
  }

  _queueAllyMove(int row, int column, Direction direction) {
    Timer(Duration(milliseconds: 500), () {
      if (this._grid[row][column].status == BlockStatus.ENEMY) {
        return;
      }
      if (direction == Direction.DOWN) {
        _moveAllyDown(row, column);
      }
    });
  }

  _moveAllyDown(int row, int column) {
    if (row >= this._grid.length - 1 ||
        this._grid[row + 1][column].status == BlockStatus.BARRIER) {
      this._markCellAsEmpty(row, column);
      this._checkForAllyBlocks();
    } else if (this._grid[row + 1][column].status == BlockStatus.EMPTY ||
        this._grid[row + 1][column].status == BlockStatus.ENEMY) {
      this._markCellAsEmpty(row, column);
      if (this._grid[row + 1][column].status == BlockStatus.ENEMY) {
        this._blockCount += 1;
        this._calculatePercentageLeft();
        this._removeEnemy(this._grid[row + 1][column].id);
      }
      this._markCellAsAlly(row + 1, column);
      _queueAllyMove(row + 1, column, Direction.DOWN);
    }
    if (!this._isGameWon || !this._isGameOver) {
      notifyListeners();
    }
  }

  _removeEnemy(int id) {
    this._enemies.removeWhere((enemy) => enemy.id == id);
    if (this._enemies.length <= 0) {
      this._isGameWon = true;
      PlayerData.setScore(this._levelGroup, this._levelNumber, this._blockCount,
          this.calculatedStars(this._stars));
    }
  }

  clearGrid() {
    if (this._enemies.length > 0) {
      this._enemies = [];
    }
  }

  highlightColumn(int column) {
    this._grid.forEach((row) {
      if (row[column].status != BlockStatus.BARRIER) {
        row[column].setHighlighted(true);
      }
    });
    notifyListeners();
  }

  unHighlightColumn(int column) {
    this._grid.forEach((row) => row[column].setHighlighted(false));
    notifyListeners();
  }

  void _calculatePercentageLeft() {
    this._blockPercentage = this._blockCount / this._stars['three'];
  }

  double get blockPercentage {
    return this._blockPercentage > 1.0 ? 1.0 : this._blockPercentage;
  }

  void _checkForAllyBlocks() {
    if (this._blockCount <= 0) {
      bool hasAlly = false;
      this._grid.forEach((row) {
        if (!hasAlly)
          hasAlly = row.any((block) => block.status == BlockStatus.ALLY);
      });
      if (!hasAlly) {
        this._isGameOver = true;
      }
    }
  }

  int calculatedStars(Map<String, int> stars) {
    if (this._blockCount >= stars['three']) {
      return 3;
    } else if (this._blockCount >= stars['two']) {
      return 2;
    } else if (this._blockCount >= stars['one']) {
      return 1;
    } else {
      return 0;
    }
  }
}
