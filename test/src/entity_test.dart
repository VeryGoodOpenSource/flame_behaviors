// ignore_for_file: cascade_invocations

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

class TestEntity extends Entity {
  TestEntity({
    super.behaviors,
  });
}

class TestBehavior extends Behavior<TestEntity> {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Entity', () {
    flameTester.test('adds behaviors directly to itself', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity(behaviors: [behavior]);

      await game.ensureAdd(entity);

      expect(entity.children.contains(behavior), isTrue);
    });

    flameTester.test('adds behaviors to itself', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity();

      await entity.ensureAdd(behavior);
      await game.ensureAdd(entity);

      expect(entity.children.contains(behavior), isTrue);
    });

    flameTester.test(
      'behavior can be removed from entity and the internal cache',
      (game) async {
        final behavior = TestBehavior();
        final entity = TestEntity(behaviors: []);

        await game.ensureAdd(entity);

        expect(entity.findBehavior<TestBehavior>(), isNull);
        await entity.ensureAdd(behavior);
        expect(entity.findBehavior<TestBehavior>(), isNotNull);

        behavior.removeFromParent();
        await game.ready();
        expect(entity.findBehavior<TestBehavior>(), isNull);
      },
    );

    flameTester.test(
      'can correctly confirm if it has a behavior',
      (game) async {
        final behavior = TestBehavior();
        final entity = TestEntity(behaviors: []);

        await game.ensureAdd(entity);

        expect(entity.hasBehavior<TestBehavior>(), isFalse);
        await entity.ensureAdd(behavior);
        expect(entity.hasBehavior<TestBehavior>(), isTrue);

        behavior.removeFromParent();
        await game.ready();
        expect(entity.hasBehavior<TestBehavior>(), isFalse);
      },
    );
  });
}
