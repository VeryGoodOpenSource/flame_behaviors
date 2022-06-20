import 'dart:math';

import 'package:example/entities/entities.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class ExampleGame extends FlameGame
    with HasCollisionDetection, HasDraggables, HasTappables {
  @override
  Future<void> onLoad() async {
    await add(FpsTextComponent(position: Vector2.zero()));
    await add(ScreenHitbox());

    var shapeEntity = _randomEntity(
      position: size / 2,
      size: Vector2.all(50) + Vector2.random(_rng) * 100,
    );
    await add(shapeEntity);

    for (var i = 0; i < 50; i++) {
      shapeEntity = nextRandomEntity(shapeEntity);
      await add(shapeEntity);
    }
  }

  final _rng = Random();

  Entity nextRandomEntity(Entity entity) {
    final size = Vector2.all(50) + Vector2.random(_rng) * 100;
    return _randomEntity(position: this.size / 2, size: size);
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
