import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class RotationBehavior extends Behavior with HasGameRef {
  RotationBehavior({required this.rotationSpeed});

  final double rotationSpeed;

  late final ScreenHitbox screenHitbox;

  @override
  Future<void> onLoad() async {
    screenHitbox = gameRef.children.whereType<ScreenHitbox>().first;
  }

  @override
  void update(double dt) {
    final angleDelta = dt * rotationSpeed;
    parent.angle = (parent.angle + angleDelta) % (2 * pi);
  }
}
