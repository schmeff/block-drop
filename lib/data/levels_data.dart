class LevelsData {
  static Map<int, Object> levels = {
    1: {
      "number": 1,
      "levelDimensions": {"rows": 5, "columns": 5},
      "enemies": [
        {
          "id": 0,
          "position": {"row": 4, "column": 0},
          "status": 1,
          "route": [0, 0, 1, 1]
        }
      ],
      "blockCount": 5,
      "stars": {"one": 1, "two": 3, "three": 5},
    },
    2: {
      "number": 2,
      "levelDimensions": {"rows": 5, "columns": 5},
      "enemies": [
        {
          "id": 0,
          "position": {"row": 2, "column": 4},
          "status": 1,
          "route": [2, 2, 2, 2, 3, 3, 3, 3]
        },
        {
          "id": 1,
          "position": {"row": 3, "column": 0},
          "status": 1,
          "route": [3, 3, 3, 3, 2, 2, 2, 2]
        },
      ],
      "blockCount": 5,
      "stars": {"one": 1, "two": 3, "three": 5},
    },
    3: {
      "number": 3,
      "levelDimensions": {"rows": 5, "columns": 5},
      "enemies": [
        {
          "id": 0,
          "position": {"row": 4, "column": 4},
          "status": 1,
          "route": [0, 0, 1, 1]
        }
      ],
      "blockCount": 5,
      "stars": {"one": 1, "two": 3, "three": 7},
    },
  };
}
