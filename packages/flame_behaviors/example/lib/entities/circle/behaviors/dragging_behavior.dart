import 'package:example/entities/entities.dart';
import 'package:flame/experimental.dart' hide Circle;
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class DraggingBehavior extends DraggableBehavior<Circle> {
  MovingBehavior? movement;

  Vector2? originalVelocity;

  @override
  Future<void> onLoad() async {
    movement = parent.findBehavior<MovingBehavior>();
  }

  @override
  void onDragStart(DragStartEvent event) {
    originalVelocity = movement?.velocity.clone();
    movement?.velocity.setFrom(Vector2.zero());
    return super.onDragStart(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    movement?.velocity.setFrom(originalVelocity ?? Vector2.zero());
    return super.onDragCancel(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    movement?.velocity.setFrom(event.velocity);
    return onDragEnd(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    parent.position.add(event.delta);
  }
}
