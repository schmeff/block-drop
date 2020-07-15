import 'package:flutter_test/flutter_test.dart';

import '../lib/providers/block.dart';

void main() {
  test("Block getters", () {
    Block block = Block(
        Position(5, 5), BlockStatus.ENEMY, [Direction.DOWN, Direction.UP], 4);

    expect(block.id, equals(4));
    expect(block.incrementDirection, equals(Direction.DOWN));
    expect(block.incrementDirection, equals(Direction.UP));
    expect(block.status, equals(BlockStatus.ENEMY));
    expect(block.position.row, equals(5));
    expect(block.position.column, equals(5));
  });

  test("Block setters", () {
    Block block = Block(
        Position(5, 5), BlockStatus.ENEMY, [Direction.DOWN, Direction.UP], 4);

    block.setId(100);
    expect(block.id, equals(100));
    block.setPosition(10, 10);
    expect(block.position.row, 10);
    expect(block.position.column, 10);
    block.setStatus(BlockStatus.ALLY);
    expect(block.status, BlockStatus.ALLY);
  });

  test("calling next direction on block will increment each time", () {
    Block block = Block(
        Position(5, 5), BlockStatus.ENEMY, [Direction.DOWN, Direction.UP], 4);

    expect(block.incrementDirection, equals(Direction.DOWN));
    expect(block.incrementDirection, equals(Direction.UP));
    expect(block.incrementDirection, equals(Direction.DOWN));
    expect(block.incrementDirection, equals(Direction.UP));
  });
}