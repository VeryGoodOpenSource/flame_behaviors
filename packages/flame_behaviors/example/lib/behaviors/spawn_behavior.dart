import 'dart:math';

import 'package:example/entities/entities.dart';
import 'package:example/main.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class SpawnBehavior extends TappableBehavior<ExampleGame> {
  final _rng = Random();

  @override
  Future<void> onLoad() async {
    await parent.add(nextRandomEntity(parent.size / 2));

    for (var i = 0; i < 5; i++) {
      await parent.add(nextRandomEntity(parent.size / 2));
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    parent.add(nextRandomEntity(info.eventPosition.game));

    return super.onTapDown(info);
  }

  PositionedEntity nextRandomEntity(Vector2 position) {
    final size = Vector2.all(50) + Vector2.random(_rng) * 100;
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
