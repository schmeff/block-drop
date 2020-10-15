import 'dart:convert';

import '../data/levels_data.dart';

import '../providers/level.dart';
import '../providers/block.dart';

class LevelConverter {
  static String toJson(Level level) => jsonEncode(level);

  static Level getLevel(String group, int number) {
    Map<String, dynamic> level = LevelsData.levels[group][number];

    int levelNumber = level['number'];
    LevelDimensions dimensions = LevelDimensions(
        level['levelDimensions']['rows'], level['levelDimensions']['columns']);
    List<Block> enemies = List();
    level['enemies'].forEach((enemy) {
      int id = enemy['id'];
      Position position =
          Position(enemy['position']['row'], enemy['position']['column']);
      BlockStatus status = BlockStatus.values[enemy['status']];
      List<Direction> route = List<Direction>.from(enemy['route']
              .map((direction) => Direction.values[direction])
              .toList())
          .toList();
      enemies.add(Block(position, status, route, id));
    });
    List<Block> barriers = List();
    if (level.containsKey('barriers')) {
      level['barriers'].forEach((barrier) {
        Position position =
            Position(barrier['position']['row'], barrier['position']['column']);
        BlockStatus status = BlockStatus.values[barrier['status']];
        List<Direction> route = List();
        barriers.add(Block(position, status, route));
      });
    }
    int blockCount = level['blockCount'];
    Map<String, int> stars = level['stars'];

    return Level(levelNumber, dimensions, enemies, barriers, blockCount, stars);
  }
}

void main() {
  Level l = LevelConverter.getLevel("5x5", 1);
  print(l);
}
