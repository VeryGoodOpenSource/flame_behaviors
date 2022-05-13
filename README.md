# Flame Behaviors

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]
[![Very Good Ventures][logo_black]][very_good_ventures_link_light]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![pub package][pub_badge]][pub_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Flame][flame_badge_link]]([flame_link])

---

An implementation of the behavioral composition pattern for Flame.

---

## Installation 💻

```
flutter pub add flame_behaviors
```

## Usage ✨

### Behavior

A behavior is a component that defines how an entity behaves. It can be attached to an `Entity` and handle a specific behavior for that entity.

A behavior can have it's own `Component`s for adding extra functionality related to the behavior. It cannot, however, have its own `Behavior`s.

```dart
// Define a custom behavior by extending `Behavior`.
class CollisionBehavior extends Behavior with CollisionCallbacks {
  CollisionBehavior(this._hitbox) : super(children: [_hitbox]);

  final RectangleHitbox _hitbox;

  @override
  Future<void> onLoad() async {...}

  @override
  @mustCallSuper
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {...}
```

### Entity

The entity is the building block of a game. It represents a visual game object that can hold multiple `Behavior`s which in turn define how the entity behaves.

```dart
// Define a custom entity by extending `Entity`.
class MyEntity extends Entity {
  MyEntity() : super(behaviors: [CollisionBehavior(RectangleHitbox()]);
}
```

[ci_badge]: https://github.com/VeryGoodOpenSource/flame_behaviors/workflows/flame_behaviors/badge.svg
[ci_link]: https://github.com/VeryGoodOpenSource/flame_behaviors/actions
[coverage_badge]: https://raw.githubusercontent.com/VeryGoodOpenSource/flame_behaviors/main/coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[pub_badge]: https://img.shields.io/pub/v/flame_behaviors.svg
[pub_link]: https://pub.dartlang.org/packages/flame_behaviors
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=CLI
[very_good_ventures_link_dark]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=CLI#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=CLI#gh-light-mode-only
[flame_badge_link]: https://img.shields.io/badge/Powered%20by-%F0%9F%94%A5-orange.svg
[flame_link]: https://flame-engine.org
