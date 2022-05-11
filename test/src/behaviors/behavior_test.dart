// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_game.dart';

class TestEntity extends Entity {
  TestEntity({Iterable<Behavior>? behaviors}) : super(behaviors: behaviors);
}

class TestBehavior extends Behavior<TestEntity> {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Behavior', () {
    flameTester.test('can be added to an Entity', (game) async {
      final testBehavior = TestBehavior();
      final testEntity = TestEntity(
        behaviors: [testBehavior],
      );

      await game.ensureAdd(testEntity);
      expect(game.descendants().whereType<TestBehavior>().length, equals(1));
      expect(testEntity.children.contains(testBehavior), isTrue);
    });

    group('children', () {
      late TestBehavior testBehavior;
      late TestEntity testEntity;

      setUp(() {
        testBehavior = TestBehavior();
        testEntity = TestEntity(
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
          () => testBehavior.add(TestBehavior()),
          failsAssert('Behaviors cannot have behaviors.'),
        );
      });

      flameTester.test('can not have entities as children', (game) async {
        await game.ensureAdd(testEntity);

        expect(
          () => testBehavior.add(TestEntity()),
          failsAssert('Behaviors cannot have entities.'),
        );
      });
    });
  });
}
