import 'package:example/behaviors/behaviors.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class ExampleGame extends FlameGame
    with EntityMixin, HasCollisionDetection, HasDraggables, HasTappables {
  @override
  Future<void> onLoad() async {
    await add(FpsTextComponent(position: Vector2.zero()));
    await add(ScreenHitbox());

    // Game-specific behaviors
    await add(SpawnBehavior());

    return super.onLoad();
  }
}

void main() {
  runApp(GameWidget(game: ExampleGame()));
}
