// ignore_for_file: cascade_invocations

import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

class TestEntity extends Entity {
  TestEntity({Iterable<Behavior>? behaviors}) : super(behaviors: behaviors);
}

class TestBehavior extends Behavior<TestEntity> {}

void main() {
  final flameTester = FlameTester(FlameGame.new);

  group('Entity', () {
    flameTester.test('adds behaviors to itself', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity(behaviors: [behavior]);

      await game.ensureAdd(entity);

      expect(entity.children.contains(behavior), isTrue);
    });
  });
}
