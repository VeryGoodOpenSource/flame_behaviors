import 'package:example/behaviors/behaviors.dart';
import 'package:example/entities/entities.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class DraggingBehavior extends DraggableBehavior<Circle> {
  MovementBehavior? movement;

  Vector2? originalVelocity;

  @override
  Future<void> onLoad() async {
    movement = parent.findBehavior<MovementBehavior>();
  }

  @override
  bool onDragStart(DragStartInfo info) {
    originalVelocity = movement?.velocity.clone();
    movement?.velocity.setFrom(Vector2.zero());
    return false;
  }

  @override
  bool onDragCancel() {
    movement?.velocity.setFrom(originalVelocity ?? Vector2.zero());
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    movement?.velocity.setFrom(info.velocity);
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    parent.position.add(info.delta.game);
    return false;
  }
}
