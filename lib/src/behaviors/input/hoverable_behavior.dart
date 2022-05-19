import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template hoverable_behavior}
/// A behavior that makes an [Entity] hoverable.
///
/// When using this behavior, also add `HasHoverables` to your game, which
/// handles propagation of hover events from the root game to individual
/// behaviors.
/// {@endtemplate}
abstract class HoverableBehavior<Parent extends Entity> extends Behavior<Parent>
    with Hoverable {}
