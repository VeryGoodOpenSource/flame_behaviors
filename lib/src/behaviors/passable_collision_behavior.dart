import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template collision_behavior}
/// A collision behavior that can be attached to an entity.
/// {@endtemplate}
abstract class CollisionBehavior<Collider extends Component,
    Parent extends Entity> extends Behavior<Parent> {
  /// Check if the given component is the Collider.
  bool isValid(Component c) => c is Collider;

  /// Called when the entity collides with [Collider].
  void onCollision(
    Set<Vector2> intersectionPoints,
    Collider other,
  );
}

/// {@template passable_collision_behavior}
/// This behavior is used to handle collisions between entities. It will pass
/// the collision through to any [CollisionBehavior]s that are attached to the
/// entity.
///
/// The [CollisionBehavior]s are filtered by the [CollisionBehavior.isValid]
/// method.
/// {@endtemplate}
class PassableCollisionBehavior extends Behavior with CollisionCallbacks {
  /// {@macro passable_collision_behavior}
  PassableCollisionBehavior(this._hitbox) : super(children: [_hitbox]);

  final RectangleHitbox _hitbox;

  @override
  Future<void> onLoad() async {
    _hitbox.onCollisionCallback = onCollision;
    parent.children.register<CollisionBehavior>();
    _passToBehaviors = parent.children.query<CollisionBehavior>();
  }

  /// List of [CollisionBehavior]s to which it can pass to.
  List<CollisionBehavior> _passToBehaviors = [];

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other.parent is! PassableCollisionBehavior && other.parent is! Entity) {
      return super.onCollision(intersectionPoints, other);
    }
    final parent = other.parent;

    final otherEntity = parent is Entity
        ? parent
        : (parent as PassableCollisionBehavior?)!.parent;

    for (final behavior in _passToBehaviors) {
      if (behavior.isValid(otherEntity)) {
        behavior.onCollision(intersectionPoints, otherEntity);
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
