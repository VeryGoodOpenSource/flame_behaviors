import 'package:example/entities/entities.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class FreezingBehavior extends TappableBehavior<Rectangle> {
  MovingBehavior? movement;

  Vector2? originalVelocity;

  @override
  Future<void> onLoad() async {
    movement = parent.findBehavior<MovingBehavior>();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (movement?.velocity.isZero() ?? false) {
      movement?.velocity.setFrom(originalVelocity ?? Vector2.zero());
    } else {
      originalVelocity = movement?.velocity.clone();
      movement?.velocity.setFrom(Vector2.zero());
    }
    return false;
  }
}
