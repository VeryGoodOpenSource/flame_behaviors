import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template entity}
/// The entity is the building block of a game. It represents a visual game
/// object that can hold multiple [Behavior]s which in turn define how the
/// entity behaves.
///
/// The visualization of the entity is defined by the [Component]s that are
/// attached to it.
/// {@endtemplate}
abstract class Entity extends PositionComponent {
  /// {@macro entity}
  Entity({
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    Iterable<Component>? children,
    int? priority,
    Iterable<Behavior>? behaviors,
  })  : assert(
          children?.whereType<Behavior>().isEmpty ?? true,
          'Behaviors cannot be added to as a child directly.',
        ),
        super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          children: children,
          priority: priority,
        ) {
    if (behaviors != null) {
      addAll(behaviors);
    }
  }

  late final List<Behavior> _behaviors;

  @override
  Future<void>? onLoad() {
    children.register<Behavior>();
    _behaviors = children.query<Behavior>();

    return super.onLoad();
  }

  /// Returns a list of behaviors with the given type, that are attached to
  /// this entity.
  Iterable<T> findBehaviors<T extends Behavior>() {
    return _behaviors.whereType<T>();
  }

  /// Returns the first behavior with the given type, that is attached to this
  /// entity.
  T? findBehavior<T extends Behavior>() {
    final it = findBehaviors<T>().iterator;
    return it.moveNext() ? it.current : null;
  }
}
