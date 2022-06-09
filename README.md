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

### Entity

The entity is the building block of a game. It represents a visual game object that can hold 
multiple `Behavior`s which in turn define how the entity behaves.

```dart
// Define a custom entity by extending `Entity`.
class MyEntity extends Entity {
  MyEntity() : super(behaviors: [MyBehavior()]);
}
```

### Behavior

A behavior is a component that defines how an entity behaves. It can be attached to an `Entity` 
and handle a specific behavior for that entity. Behaviors can either be generic for any entity 
or you can specify the specific type of entity that a behavior requires:

```dart
// Can be added to any type of Entity.
class MyGenericBehavior extends Behavior {
  ...
}

// Can only be added to MyEntity and subclasses of it.
class MySpecificBehavior extends Behavior<MyEntity> {
  ...
}
```

Each behavior can have its own `Component`s for adding extra functionality related to the 
behavior. For instance a `TimerComponent` can implement a time-based behavioral activity:

```dart
class MyBehavior extends Behavior {
  @override
  Future<void> onLoad() async {
    await add(TimerComponent(period: 5, repeat: true, onTick: _onTick));
  }

  void _onTick() {
    // Do something every 5 seconds.
  }
}
```

**Note**: A behavior, by definition, cannot have it's own `Behavior`s. 

#### Input behaviors

The `flame_behaviors` package also provides input behaviors. These behaviors are a 
layer over the existing Flame input mixins for components. These behaviors will 
trigger when their parent entity is being interacted with by the user. So these events 
are always relative to the parent entity.

```dart
class MyDraggableBehavior extends DraggableBehavior<MyEntity> {
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    // Do something on drag update event.
    return super.onDragUpdate(info);
  }
}
```

**Note**: You still need to add the corresponding input mixins to your game class, see the 
[Flame input docs](https://docs.flame-engine.org/1.2.0/flame/inputs/inputs.html) for more 
information.

### Collision detection

Flame comes with a powerful built-in [collision detection system](https://docs.flame-engine.org/1.2.0/flame/collision_detection.html) 
but this API is not strongly typed. Components always get the colliding component as a 
`PositionComponent` and developers need to manually check what type of class it exactly is. And 
because `flame_behaviors` is all about enforcing a strongly typed API, it provide a special 
behavior called `CollisionBehavior` that describe what type of entity it is interested for 
collision. It does not however do any real collision detection, that is done by the 
`PropagatingCollisionBehavior`.

It does this by registering a hitbox on the parent entity and when that hitbox has a collision the 
`PropagatingCollisionBehavior` checks if the component that the parent entity is colliding with is 
of a any interested for any of the `CollisionBehavior` on the parent entity.

This comes with two benefits, the first and most important one is performance. By only registering
collision callbacks on the entities themselves the collision detection system does not have to 
go through any "collidable" behaviors, for which there could be many per entity. We only do that now
if we confirm a collision has happened. The second benefit is [separation-of-concerns](https://en.wikipedia.org/wiki/Separation_of_concerns).
Each `CollisionBehavior` handles a specific collision use-case and ensures the developer does not
have to write a bunch of if statements in one big method to figure out what it is colliding with.

A good use case of this can be seen in the `flame_behaviors` [example](https://github.com/VeryGoodOpenSource/flame_behaviors/tree/main/example)

```dart
class MyEntityCollisionBehavior extends CollisionBehavior<MyCollidingEntity, MyParentEntity> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, MyCollidingEntity other) {
    // We are starting colliding with MyCollidingEntity
  }

  @override
  void onCollisionEnd(MyCollidingEntity other) {
    // We stopped colliding with MyCollidingEntity
  }
}

class MyParentEntity extends Entity {O
  MyParentEntity() : super(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            MyEntityCollisionBehavior(),
          ],
        );
  
  ...
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
