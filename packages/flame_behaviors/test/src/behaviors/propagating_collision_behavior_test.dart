// ignore_for_file: cascade_invocations

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

class _EntityA extends PositionedEntity {
  _EntityA({
    super.behaviors,
  }) : super(size: Vector2.all(16));
}

class _EntityB extends PositionedEntity {
  _EntityB({
    super.behaviors,
  }) : super(size: Vector2.all(16));
}

class _EntityC extends PositionedEntity {
  _EntityC() : super(size: Vector2.all(16));
}

abstract class _CollisionBehavior<A extends Component,
    B extends PositionedEntity> extends CollisionBehavior<A, B> {
  bool onCollisionStartCalled = false;
  bool onCollisionCalled = false;
  bool onCollisionEndCalled = false;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, A other) {
    super.onCollisionStart(intersectionPoints, other);
    onCollisionStartCalled = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, A other) {
    super.onCollision(intersectionPoints, other);
    onCollisionCalled = true;
  }

  @override
  void onCollisionEnd(A other) {
    super.onCollisionEnd(other);
    onCollisionEndCalled = true;
  }
}

class _CollisionBehaviorAtoB extends _CollisionBehavior<_EntityB, _EntityA> {}

class _CollisionBehaviorAtoC extends _CollisionBehavior<_EntityC, _EntityA> {}

class _CollisionBehaviorAtoComponent
    extends _CollisionBehavior<PositionComponent, _EntityA> {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('CollisionBehavior', () {
    flameTester.testGameWidget(
      'isColliding returns true if it is current colliding with the Collider',
      setUp: (game, tester) async {
        final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
        final entityA = _EntityA(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            collisionBehaviorAtoB,
          ],
        );

        final entityB = _EntityB(
          behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
        );

        await game.ensureAdd(entityA);
        await game.ensureAdd(entityB);
      },
      verify: (game, tester) async {
        final entityA = game.firstChild<_EntityA>()!;
        final collisionBehaviorAtoB =
            entityA.firstChild<_CollisionBehaviorAtoB>()!;

        game.update(0);

        expect(collisionBehaviorAtoB.isColliding, isTrue);
      },
    );

    flameTester.testGameWidget(
      'isColliding returns false if it is not colliding with any Colliders',
      setUp: (game, tester) async {
        final collisionBehaviorAtoC = _CollisionBehaviorAtoC();
        final entityA = _EntityA(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            collisionBehaviorAtoC,
          ],
        );

        final entityB = _EntityB(
          behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
        );

        await game.ensureAdd(entityA);
        await game.ensureAdd(entityB);
      },
      verify: (game, tester) async {
        final entityA = game.firstChild<_EntityA>()!;
        final collisionBehaviorAtoC =
            entityA.firstChild<_CollisionBehaviorAtoC>()!;

        game.update(0);

        expect(collisionBehaviorAtoC.isColliding, isFalse);
      },
    );
  });

  group('PropagatingCollisionBehavior', () {
    flameTester.testGameWidget(
      'can be added to an Entity',
      setUp: (game, tester) async {
        final passableCollisionBehavior = PropagatingCollisionBehavior(
          RectangleHitbox(),
        );
        final entityA = _EntityA(behaviors: [passableCollisionBehavior]);

        await game.ensureAdd(entityA);
      },
      verify: (game, tester) async {
        final entityA = game.firstChild<_EntityA>()!;
        final passableCollisionBehavior =
            entityA.firstChild<PropagatingCollisionBehavior>()!;

        expect(
          entityA.findBehavior<PropagatingCollisionBehavior>(),
          equals(passableCollisionBehavior),
        );
        expect(
          passableCollisionBehavior.children
              .whereType<RectangleHitbox>()
              .length,
          equals(1),
        );
      },
    );

    group('propagates collision', () {
      flameTester.testGameWidget(
        'on start to the correct collision behavior',
        setUp: (game, tester) async {
          final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
          final collisionBehaviorAtoC = _CollisionBehaviorAtoC();
          final collisionBehaviorAtoComponent =
              _CollisionBehaviorAtoComponent();
          final entityA = _EntityA(
            behaviors: [
              PropagatingCollisionBehavior(RectangleHitbox()),
              collisionBehaviorAtoB,
              collisionBehaviorAtoC,
              collisionBehaviorAtoComponent,
            ],
          );

          final entityB = _EntityB(
            behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
          );

          final positionComponent = PositionComponent(
            size: Vector2.all(16),
            children: [
              RectangleHitbox(),
            ],
          );

          await game.ensureAdd(entityA);
          await game.ensureAdd(entityB);
          await game.ensureAdd(positionComponent);
        },
        verify: (game, tester) async {
          final entityA = game.firstChild<_EntityA>()!;
          final collisionBehaviorAtoB =
              entityA.firstChild<_CollisionBehaviorAtoB>()!;
          final collisionBehaviorAtoC =
              entityA.firstChild<_CollisionBehaviorAtoC>()!;
          final collisionBehaviorAtoComponent =
              entityA.firstChild<_CollisionBehaviorAtoComponent>()!;

          game.update(0);

          expect(collisionBehaviorAtoB.onCollisionStartCalled, isTrue);
          expect(collisionBehaviorAtoC.onCollisionStartCalled, isFalse);
          expect(collisionBehaviorAtoComponent.onCollisionStartCalled, isTrue);
        },
      );

      flameTester.testGameWidget(
        'on collision to the correct collision behavior',
        setUp: (game, tester) async {
          final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
          final entityA = _EntityA(
            behaviors: [
              PropagatingCollisionBehavior(RectangleHitbox()),
              collisionBehaviorAtoB,
            ],
          );

          final entityB = _EntityB(
            behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
          );

          await game.ensureAdd(entityA);
          await game.ensureAdd(entityB);
        },
        verify: (game, tester) async {
          final entityA = game.firstChild<_EntityA>()!;
          final collisionBehaviorAtoB =
              entityA.firstChild<_CollisionBehaviorAtoB>()!;

          game.update(0);

          expect(collisionBehaviorAtoB.onCollisionCalled, isTrue);
        },
      );

      flameTester.testGameWidget(
        'on end to the correct collision behavior',
        setUp: (game, tester) async {
          final collisionBehaviorAtoB = _CollisionBehaviorAtoB();
          final collisionBehaviorAtoC = _CollisionBehaviorAtoC();
          final collisionBehaviorAtoComponent =
              _CollisionBehaviorAtoComponent();
          final entityA = _EntityA(
            behaviors: [
              PropagatingCollisionBehavior(RectangleHitbox()),
              collisionBehaviorAtoB,
              collisionBehaviorAtoC,
              collisionBehaviorAtoComponent,
            ],
          );

          final entityB = _EntityB(
            behaviors: [PropagatingCollisionBehavior(RectangleHitbox())],
          );

          final positionComponent = PositionComponent(
            size: Vector2.all(16),
            children: [RectangleHitbox()],
          );

          await game.ensureAdd(positionComponent);
          await game.ensureAdd(entityA);
          await game.ensureAdd(entityB);
        },
        verify: (game, tester) async {
          final entityA = game.firstChild<_EntityA>()!;
          final collisionBehaviorAtoB =
              entityA.firstChild<_CollisionBehaviorAtoB>()!;
          final collisionBehaviorAtoC =
              entityA.firstChild<_CollisionBehaviorAtoC>()!;
          final collisionBehaviorAtoComponent =
              entityA.firstChild<_CollisionBehaviorAtoComponent>()!;

          final entityB = game.firstChild<_EntityB>()!;
          final positionComponent = game.firstChild<PositionComponent>()!;

          game.update(0);

          expect(collisionBehaviorAtoB.onCollisionEndCalled, isFalse);
          expect(collisionBehaviorAtoC.onCollisionEndCalled, isFalse);
          expect(collisionBehaviorAtoComponent.onCollisionEndCalled, isFalse);

          entityB.position += Vector2.all(50);
          positionComponent.position += Vector2.all(50);

          game.update(0);

          expect(collisionBehaviorAtoB.onCollisionEndCalled, isTrue);
          expect(collisionBehaviorAtoC.onCollisionEndCalled, isFalse);
          expect(collisionBehaviorAtoComponent.onCollisionEndCalled, isTrue);
        },
      );
    });
  });
}
