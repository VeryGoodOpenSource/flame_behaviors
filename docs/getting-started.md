# Getting Started 🚀

## Prerequisites 📝

In order to use Flame Behaviors you must have the [Flame package][flame_package_link] added to 
your project.

> **Note**: Flame Behaviors requires Flame `">=1.2.0 <2.0.0"`

## Installing 🧑‍💻

Let's start by adding the [`flame_behaviors`][flame_behaviors_package_link] package:

```shell
# 📦 Add the flame_behaviors package from pub.dev to your project
flutter pub add flame_behaviors
```

## Entity

The entity is the building block of a game. It represents a visual game object that can hold 
multiple `Behavior`s, which in turn define how the entity behaves.

```dart
// Define a custom entity by extending `Entity`.
class MyEntity extends Entity {
  MyEntity() : super(behaviors: [MyBehavior()]);
}
```

## Behavior

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

### Behavior composition

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

**Note**: A `Behavior` is a non-visual component that describes how a visual component (Entity) 
behaves. To ensure this rule, a behavior can't have its own `Behavior`s.

## Whats next

TODO(wolfen): describe next steps, article, conventions and collision/input

[flame_package_link]: https://pub.dev/packages/flame
[flame_behaviors_package_link]: https://pub.dev/packages/flame_behaviors
