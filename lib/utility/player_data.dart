import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PlayerData {
  static void setScore(
    String group,
    int level,
    int remainingBlocks,
    int starCount,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final scoreData = json.encode({
      'group': group,
      'level': level,
      'remainingBlocks': remainingBlocks,
      'stars': starCount,
    });
    if (!preferences.containsKey(group)) {
      preferences.setStringList(group, [scoreData]);
    } else {
      List<String> scores = preferences.getStringList(group);
      String oldScore = scores.firstWhere(
        (score) => json.decode(score)['level'] == level,
        orElse: () => null,
      );
      if (oldScore == null) {
        scores.add(scoreData);
        preferences.setStringList(group, scores);
      } else if (compareScores(
          json.decode(oldScore)['remainingBlocks'], remainingBlocks)) {
        scores.removeWhere((score) => json.decode(score)['level'] == level);
        scores.add(scoreData);
        preferences.setStringList(group, scores);
      }
    }
  }

  static getGroupScores(String group) async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(group)) {
      return null;
    }
    return preferences.getStringList(group).map((e) => json.decode(e)).toList();
  }

  static Future<Map> getLevelScore(String group, int level) async {
    List<Map> g = await getGroupScores(group);

    g.firstWhere((l) => l['level'] == level, orElse: () => null);
  }

  static bool compareScores(int oldScore, int newScore) {
    return newScore > oldScore;
  }
}
