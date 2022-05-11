import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template collision_behavior}
/// This behavior is used for collision between entities. The
/// [PassableCollisionBehavior] passes the collision to this behavior if the
/// entity that is colliding with the [Parent] is an instance of [Collider].
/// {@endtemplate}
abstract class CollisionBehavior<Collider extends Component,
    Parent extends Entity> extends Behavior<Parent> {
  /// Check if the given component is an instance of [Collider].
  bool isValid(Component c) => c is Collider;

  /// Called when the entity collides with [Collider].
  void onCollision(
    Set<Vector2> intersectionPoints,
    Collider other,
  );
}

/// {@template passable_collision_behavior}
/// This behavior is used to handle collisions between entities and pass
/// the collision through to any [CollisionBehavior]s that are attached to the
/// entity.
///
/// The [CollisionBehavior]s are filtered by the [CollisionBehavior.isValid]
/// method by checking if the colliding entity is valid for the given behavior
/// and if the colliding entity is valid the [CollisionBehavior.onCollision] is
/// called.
///
/// This allows for strongly typed collision detection. Without having to add
/// multiple collision behaviors for different types of entities or adding more
/// logic to a single collision detection behavior.
///
/// If you have an entity that does not require any [CollisionBehavior]s of its
/// own, you can just add the hitbox directly to the entity's children.
/// Any other entity that has a [CollisionBehavior] for that entity attached
/// will then be able to collide with it.
///
/// **Note**: This behavior can only be used for collisions between entities.
/// It cannot be used for collisions between an entity and a non-entity
/// component.
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
