// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_game.dart';

class _TestEntity extends Entity {
  _TestEntity({super.behaviors}) : super(size: Vector2.all(32));
}

class _TestBehavior extends Behavior<_TestEntity> {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Behavior', () {
    flameTester.test('can be added to an Entity', (game) async {
      final testBehavior = _TestBehavior();
      final testEntity = _TestEntity(
        behaviors: [testBehavior],
      );

      await game.ensureAdd(testEntity);
      expect(game.descendants().whereType<_TestBehavior>().length, equals(1));
      expect(testEntity.children.contains(testBehavior), isTrue);
    });

    flameTester.test('contains point is relative to parent', (game) async {
      final behavior = _TestBehavior();
      final entity = _TestEntity(behaviors: [behavior]);
      await game.ensureAdd(entity);

      expect(behavior.containsPoint(Vector2.zero()), isTrue);
      expect(behavior.containsPoint(Vector2(31, 31)), isTrue);
      expect(behavior.containsPoint(Vector2(32, 32)), isFalse);
    });

    flameTester.test('debugMode is provided by the parent', (game) async {
      final behavior = _TestBehavior();
      final entity = _TestEntity(behaviors: [behavior]);
      await game.ensureAdd(entity);

      expect(behavior.debugMode, isFalse);
      entity.debugMode = true;
      expect(behavior.debugMode, isTrue);
    });

    group('children', () {
      late _TestBehavior testBehavior;
      late _TestEntity testEntity;

      setUp(() {
        testBehavior = _TestBehavior();
        testEntity = _TestEntity(
          behaviors: [testBehavior],
        );
      });

      flameTester.test('can have its own children', (game) async {
        await game.ensureAdd(testEntity);

        expect(() => testBehavior.add(Component()), returnsNormally);
      });

      flameTester.test('can not have behaviors as children', (game) async {
        await game.ensureAdd(testEntity);

        expect(
          () => testBehavior.add(_TestBehavior()),
          failsAssert('Behaviors cannot have behaviors.'),
        );
      });

      flameTester.test('can not have entities as children', (game) async {
        await game.ensureAdd(testEntity);

        expect(
          () => testBehavior.add(_TestEntity()),
          failsAssert('Behaviors cannot have entities.'),
        );
      });
    });
  });
}
