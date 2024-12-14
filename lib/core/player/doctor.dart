import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../shared/sprite_sheet/person_sprite_sheet.dart';
import 'inventory.dart';

class DoctorPlayer extends SimplePlayer
    with BlockMovementCollision, ChangeNotifier {
  late Inventory inventory;

  DoctorPlayer({
    required Vector2 position,
  }) : super(
          animation: PersonSpritesheet().simpleAnimation(),
          position: position,
          size: Vector2.all(64),
          speed: 80,
        );

  @override
  Future<void> onLoad() async {
    /// Adds rectangle collision
    add(
      RectangleHitbox(
        size: size / 2,
        position: size / 4,
      ),
    );
    return super.onLoad();
  }

  @override
  void onMount() {
    inventory = GetIt.instance.get();
    inventory.reset();
    super.onMount();
  }
}
