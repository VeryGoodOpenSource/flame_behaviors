import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template behavior}
/// A component that represents a behavior.
/// {@endtemplate}
abstract class Behavior<Parent extends Entity> extends Component
    with ParentIsA<Parent> {
  /// {@macro behavior}
  Behavior({
    Iterable<Component>? children,
  }) : super(children: children);

  @override
  Future<void>? add(Component component) {
    assert(component is! Behavior, 'Behaviors cannot have behaviors.');
    return super.add(component);
  }
}
