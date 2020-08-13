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

  Future<List<Map<String, dynamic>>> get levels async {
    List groupScores =
        await PlayerData.getGroupScores(this._currentGroup) as List;

    if (groupScores == null) {
      groupScores = [];
    }

    List<int> levelNumbers =
        LevelsData.levels[this._currentGroup].keys.toList();

    List unlockedLevels = groupScores
        .map((level) => {
              'unlocked': true,
              'level': level['level'],
              'stars': level['stars']
            })
        .toList();
    unlockedLevels.sort((l1, l2) => l1['level'].compareTo(l2['level']));
    if (unlockedLevels.length < levelNumbers.length) {
      unlockedLevels
          .add({'unlocked': true, 'level': unlockedLevels.length + 1});
      levelNumbers = unlockedLevels.length < levelNumbers.length
          ? levelNumbers.sublist(unlockedLevels.length)
          : [];
      List lockedLevels =
          levelNumbers.map((n) => {'unlocked': false, 'level': n}).toList();
      unlockedLevels.addAll(lockedLevels);
    }
    return unlockedLevels;
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

  String get nextGroup {
    List<String> groups = LevelsData.levels.keys.toList();

    int groupIndex = groups.indexOf(this._currentGroup);
    if (groupIndex < groups.length - 1) {
      return groups[groupIndex + 1];
    }

    return null;
  }

  int getTotalLevelsLength(String group) {
    return LevelsData.levels[group].length;
  }

  Future<int> getCompletedLevelsStarCount(String group) async {
    List groupScores = await PlayerData.getGroupScores(group) as List;

    if (groupScores == null) {
      return 0;
    }
    int totalStars = groupScores.fold(
        0, (previousValue, current) => previousValue + current['stars']);
    return totalStars;
  }
}
