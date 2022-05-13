import 'dart:math';

import 'package:example/entities/entities.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class ExampleGame extends FlameGame with HasCollisionDetection, HasDraggables {
  @override
  Future<void> onLoad() async {
    await add(FpsTextComponent(position: Vector2.zero()));
    await add(ScreenHitbox());

    var lastToAdd = _randomEntity(
      position: Vector2.zero(),
      size: Vector2.all(50) + Vector2.random(_rng) * 100,
    );
    await add(lastToAdd);

    for (var i = 0; i < 50; i++) {
      lastToAdd = nextRandomEntity(lastToAdd);
      await add(lastToAdd);
    }
  }

  final _rng = Random();
  final _distance = Vector2(100, 0);

  Entity nextRandomEntity(Entity entity) {
    final size = Vector2.all(50) + Vector2.random(_rng) * 100;
    final isXOverflow =
        entity.position.x + entity.size.x / 2 + _distance.x + size.x > size.x;
    var position = _distance + Vector2(0, entity.position.y + 200);
    if (!isXOverflow) {
      position = (entity.position + _distance)..x += size.x / 2;
    }
    return _randomEntity(position: position, size: size);
  }

  Entity _randomEntity({
    required Vector2 position,
    required Vector2 size,
  }) {
    final rotationSpeed = 0.5 - _rng.nextDouble();
    final velocity = (Vector2.random(_rng) - Vector2.random(_rng)) * 300;

    final shapeType = Shapes.values[_rng.nextInt(Shapes.values.length)];
    switch (shapeType) {
      case Shapes.circle:
        return Circle(
          position: position,
          size: size,
          velocity: velocity,
          rotationSpeed: rotationSpeed,
        );
      case Shapes.rectangle:
        return Rectangle(
          position: position,
          size: size,
          velocity: velocity,
          rotationSpeed: rotationSpeed,
        );
    }
  }
}

enum Shapes {
  circle,
  rectangle,
}

void main() {
  runApp(GameWidget(game: ExampleGame()));
}
