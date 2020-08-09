import 'package:flutter/material.dart';
import 'package:game/utility/player_data.dart';

import './level.dart';

import '../data/levels_data.dart';

import '../utility/level_converter.dart';

class Levels with ChangeNotifier {
  int _currentLevelNumber;
  String _currentGroup;

  int get currentLevelNumber {
    return this._currentLevelNumber;
  }

  void setCurrentLevelNumber(int n) {
    this._currentLevelNumber = n;
    notifyListeners();
  }

  String get currentGroup {
    return this._currentGroup;
  }

  void setCurrentGroup(String group) {
    this._currentGroup = group;
    notifyListeners();
  }

  List<String> get groups {
    return LevelsData.levels.keys.toList();
  }

  Future<List<int>> get levels async {
    final groupScores = await PlayerData.getGroupScores(this._currentGroup);

    return LevelsData.levels[this._currentGroup].keys.toList();
  }

  Level getLevel(String group, int number) {
    return LevelConverter.getLevel(group, number);
  }

  int get nextLevelNumber {
    List<int> levelNumbers =
        LevelsData.levels[this._currentGroup].keys.toList();

    if (levelNumbers.contains(this._currentLevelNumber + 1)) {
      return this._currentLevelNumber + 1;
    }

    return null;
  }
}
