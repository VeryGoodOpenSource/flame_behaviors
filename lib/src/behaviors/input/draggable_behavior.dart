import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template draggable_behavior}
/// A behavior that makes an [Entity] draggable.
///
/// When using this behavior, also add `HasDraggables` to your game, which
/// handles propagation of drag events from the root game to individual
/// behaviors.
/// {@endtemplate}
abstract class DraggableBehavior<Parent extends Entity> extends Behavior<Parent>
    with Draggable {}
