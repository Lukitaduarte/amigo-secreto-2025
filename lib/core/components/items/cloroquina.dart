import 'package:bonfire/bonfire.dart';
import 'package:get_it/get_it.dart';
import 'package:hospital_gu/core/player/inventory.dart';

class Cloroquina extends GameDecoration with TapGesture, Vision {
  bool _observedPlayer = false;

  late TextPaint _textConfig;

  Cloroquina(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            'Items/cloroquina.png',
            SpriteAnimationData.sequenced(
              amount: 1,
              stepTime: 0.2,
              textureSize: Vector2.all(22),
            ),
          ),
          size: Vector2.all(22),
          position: position,
        ) {
    _textConfig = TextPaint(
      style: TextStyle(
        color: const Color(0xFFFFFFFF),
        fontSize: width / 2,
      ),
    );
  }

  @override
  void update(double dt) {
    if (gameRef.player != null && checkInterval('SeepLayr', 500, dt)) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_observedPlayer) {
            _observedPlayer = true;
            _showEmote();
          }
        },
        notObserved: () {
          _observedPlayer = false;
        },
        radiusVision: 64,
      );
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_observedPlayer) {
      _textConfig.render(
        canvas,
        'Touch me !!',
        Vector2(width / -1.5, -height),
      );
    }
  }

  @override
  void onTap() {
    if (_observedPlayer) {
      GetIt.instance.get<Inventory>().catchCloroquina();
      removeFromParent();
    }
  }

  @override
  void onTapCancel() {}

  void _showEmote() {
    add(
      AnimatedGameObject(
        animation: SpriteAnimation.load(
          "emote_exclamacao.png",
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        size: size,
        position: size / -2,
        loop: false,
      ),
    );
  }
}
