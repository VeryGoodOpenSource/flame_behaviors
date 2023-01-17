import 'dart:math';

import 'package:example/entities/circle/behaviors/behaviors.dart';
import 'package:example/entities/entities.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class Circle extends PositionedEntity with HasPaint {
  Circle({
    super.position,
    super.size,
    required double rotationSpeed,
    required Vector2 velocity,
  }) : super(
          anchor: Anchor.center,
          behaviors: [
            PropagatingCollisionBehavior(CircleHitbox()),
            CircleCollisionBehavior(),
            RectangleCollisionBehavior(),
            ScreenCollidingBehavior(),
            MovingBehavior(velocity: velocity),
            RotatingBehavior(rotationSpeed: rotationSpeed),
            DraggingBehavior()
          ],
        );

  final defaultColor = Colors.blue.withOpacity(0.8);

  @override
  void onMount() {
    paint.color = defaultColor;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    final center = size / 2;
    canvas.drawCircle(center.toOffset(), min(size.x, size.y) / 2, paint);
  }
}
