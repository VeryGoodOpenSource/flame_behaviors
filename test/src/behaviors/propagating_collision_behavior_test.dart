// ignore_for_file: cascade_invocations

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

class _EntityA extends Entity {
  _EntityA({
    Iterable<Behavior>? behaviors,
  }) : super(size: Vector2.all(16), behaviors: behaviors);
}

class _EntityB extends Entity {
  _EntityB({
    Iterable<Behavior>? behaviors,
  }) : super(size: Vector2.all(16), behaviors: behaviors);
}

class _EntityC extends Entity {
  _EntityC({
    Iterable<Behavior>? behaviors,
    Iterable<Component>? children,
  }) : super(size: Vector2.all(16), behaviors: behaviors, children: children);
}

class _CollisionBehaviorAtoB extends CollisionBehavior<_EntityB, _EntityA> {
  bool hadACollision = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, _EntityB other) {
    hadACollision = true;
  }
}

class _CollisionBehaviorAtoC extends CollisionBehavior<_EntityC, _EntityA> {
  bool hadACollision = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, _EntityC other) {
    hadACollision = true;
  }
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PropagatingCollisionBehavior', () {
    flameTester.test('can be added to an Entity', (game) async {
      final passableCollisionBehavior = PropagatingCollisionBehavior(
        RectangleHitbox(),
      );
      final entityA = _EntityA(
        behaviors: [passableCollisionBehavior],
      );

      await game.ensureAdd(entityA);

      expect(
        entityA.findBehavior<PropagatingCollisionBehavior>(),
        equals(passableCollisionBehavior),
      );
      expect(
        passableCollisionBehavior.children.whereType<RectangleHitbox>().length,
        equals(1),
      );
    });

    group('propagates collision', () {
      flameTester.test('to the correct collision behavior', (game) async {
        final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
        final collisionBehaviorAtoC = _CollisionBehaviorAtoC();
        final entityA = _EntityA(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            collisionBehaviorAtoB,
            collisionBehaviorAtoC
          ],
        );

        final entityB = _EntityB(
          behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
        );

        await game.ensureAdd(entityA);
        await game.ensureAdd(entityB);

        game.update(0);

        expect(collisionBehaviorAtoB.hadACollision, isTrue);
        expect(collisionBehaviorAtoC.hadACollision, isFalse);
      });

      flameTester.test('only if it collides with an entity', (game) async {
        final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
        final collisionBehaviorAtoC = _CollisionBehaviorAtoC();
        final entityA = _EntityA(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            collisionBehaviorAtoB,
            collisionBehaviorAtoC
          ],
        );

        await game.ensureAdd(entityA);
        await game.ensureAdd(
          PositionComponent(
            size: Vector2.all(16),
            children: [
              RectangleHitbox(),
            ],
          ),
        );
        await game.ensureAdd(
          _EntityC(
            children: [
              RectangleHitbox(),
            ],
          ),
        );

        game.update(0);

        expect(collisionBehaviorAtoB.hadACollision, isFalse);
        expect(collisionBehaviorAtoC.hadACollision, isTrue);
      });
    });
  });
}
