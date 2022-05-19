import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template tappable_behavior}
/// A behavior that makes an [Entity] tappable.
///
/// When using this behavior, also add `HasTappables` to your game, which
/// handles propagation of tap events from the root game to individual
/// behaviors.
/// {@endtemplate}
abstract class TappableBehavior<Parent extends Entity> extends Behavior<Parent>
    with Tappable {}
