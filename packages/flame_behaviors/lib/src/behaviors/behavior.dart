import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template behavior}
/// A behavior is a component that defines how an entity behaves. It can be
/// attached to an [Entity] and handle a specific behavior for that entity.
///
/// A behavior can have it's own [Component]s for adding extra functionality
/// related to the behavior. It cannot, however, have its own [Behavior]s.
/// {@endtemplate}
abstract class Behavior<Parent extends EntityMixin> extends Component
    with ParentIsA<Parent> {
  /// {@macro behavior}
  Behavior({
    super.children,
  });

  @override
  FutureOr<void> add(Component component) {
    assert(component is! EntityMixin, 'Behaviors cannot have entities.');
    assert(component is! Behavior, 'Behaviors cannot have behaviors.');
    return super.add(component);
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }

  @override
  bool get debugMode => parent.debugMode;
}
