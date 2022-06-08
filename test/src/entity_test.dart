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
    flameTester.test('only non-behaviors can be added using add', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity();

      await expectLater(
        () => entity.add(behavior),
        failsAssert('Use the addBehavior method to add a behavior'),
      );
    });

    flameTester.test('adds behaviors directly to itself', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity(behaviors: [behavior]);

      await game.ensureAdd(entity);

      expect(entity.children.contains(behavior), isTrue);
    });

    flameTester.test('adds behaviors to itself', (game) async {
      final behavior = TestBehavior();
      final entity = TestEntity();

      await entity.addBehavior(behavior);
      await game.ensureAdd(entity);

      expect(entity.children.contains(behavior), isTrue);
    });

    flameTester.test(
      'same type of behavior cant be added if it already has one',
      (game) async {
        final behavior1 = TestBehavior();
        final behavior2 = TestBehavior();
        final entity = TestEntity();

        await game.ensureAdd(entity);
        await entity.addBehavior(behavior1);
        await game.ready();

        await expectLater(
          () => entity.addBehavior(behavior2),
          failsAssert(
            'The entity already has a behavior of the type TestBehavior',
          ),
        );

        expect(entity.children.contains(behavior1), isTrue);
        expect(entity.children.contains(behavior2), isFalse);
      },
    );

    flameTester.test(
      'behavior can be removed from entity and the internal cache',
      (game) async {
        final behavior = TestBehavior();
        final entity = TestEntity(behaviors: []);

        await game.ensureAdd(entity);

        expect(entity.findBehavior<TestBehavior>(), isNull);
        await entity.addBehavior(behavior);
        expect(entity.findBehavior<TestBehavior>(), isNotNull);

        behavior.removeFromParent();
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
        await entity.addBehavior(behavior);
        expect(entity.hasBehavior<TestBehavior>(), isTrue);

        behavior.removeFromParent();
        expect(entity.hasBehavior<TestBehavior>(), isFalse);
      },
    );
  });
}
