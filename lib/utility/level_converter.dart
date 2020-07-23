import 'dart:convert';

import '../data/levels_data.dart';

import '../providers/level.dart';
import '../providers/block.dart';

class LevelConverter {
  static String toJson(Level level) => jsonEncode(level);

  static Level getLevel(int number) {
    Map<String, dynamic> level = LevelsData.levels[number];

    int levelNumber = level['number'];
    LevelDimensions dimensions = LevelDimensions(
        level['levelDimensions']['rows'], level['levelDimensions']['columns']);
    List<Block> enemies = List();
    level['enemies'].forEach((enemy) {
      int id = enemy['id'];
      Position position =
          Position(enemy['position']['row'], enemy['position']['row']);
      BlockStatus status = BlockStatus.values[enemy['status']];
      List<Direction> route = List<Direction>.from(enemy['route']
              .map((direction) => Direction.values[direction])
              .toList())
          .toList();
      enemies.add(Block(position, status, route, id));
    });
    int blockCount = level['blockCount'];

    return Level(levelNumber, dimensions, enemies, blockCount);
  }
}

void main() {
  Level l = LevelConverter.getLevel(1);
  print(l);
}
