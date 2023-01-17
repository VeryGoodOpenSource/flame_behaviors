# Input behaviors ⌨

The `flame_behaviors` package also provides input behaviors. These behaviors are a layer over the
existing Flame input mixins for components. These behaviors will trigger when the user interacts with their parent entity. So these events are always relative to the parent entity.

## DraggableBehavior

The `DraggableBehavior` brings the [drag events][flame_drag_docs] from Flame into a behavioral
format.

```dart
class MyDraggableBehavior extends DraggableBehavior<MyEntity> {
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    // Do something on drag update event.
    return super.onDragUpdate(info);
  }
}
```

> **Note**: To use this behavior you need to add the `HasDraggables` mixin to your game class.

[flame_drag_docs]: https://docs.flame-engine.org/1.6.0/flame/inputs/gesture_input.html#draggable-components
