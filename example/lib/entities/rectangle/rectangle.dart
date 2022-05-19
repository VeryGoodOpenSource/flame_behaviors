import 'package:example/behaviors/behaviors.dart';
import 'package:example/entities/rectangle/behaviors/behaviors.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class Rectangle extends Entity with HasPaint {
  Rectangle({
    super.position,
    super.size,
    required double rotationSpeed,
    required Vector2 velocity,
  }) : super(
          anchor: Anchor.center,
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            RectangleCollisionBehavior(),
            CircleCollisionBehavior(),
            MovementBehavior(velocity: velocity),
            RotationBehavior(rotationSpeed: rotationSpeed),
            FreezeBehavior(),
          ],
        );

  final defaultColor = Colors.red.withOpacity(0.8);

  @override
  void onMount() {
    paint.color = defaultColor;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Vector2.zero() & size, paint);
  }
}
