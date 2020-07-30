import 'package:flutter/material.dart';

import './level.dart';

import '../data/levels_data.dart';

import '../utility/level_converter.dart';

class Levels with ChangeNotifier {
  int _currentLevelNumber;

  int get currentLevelNumber {
    return this._currentLevelNumber;
  }

  void setCurrentLevelNumber(int n) {
    this._currentLevelNumber = n;
    notifyListeners();
  }

  List<int> get levels {
    return LevelsData.levels.keys.toList();
  }

  Level getLevel(int number) {
    return LevelConverter.getLevel(number);
  }
}
