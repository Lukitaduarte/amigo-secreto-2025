import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/utils/custom_sprite_animation_widget.dart';

class Nurse3 extends SimpleNpc {
  bool _showConversation = false;

  Nurse3(Vector2 position)
      : super(
          position: position, // required
          size: Vector2.all(50), // required
          initDirection: Direction.right,
          animation: SimpleDirectionAnimation(
            idleRight: idleRight(),
            runRight: SpriteAnimation.load(
              'Npcs/nurse3_idle.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(36),
                texturePosition: Vector2(16, 16),
              ),
            ),
            runUpRight: SpriteAnimation.load(
              'Npcs/nurse3_idle.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(36),
                texturePosition: Vector2(16, 16),
              ),
            ),
          ),
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
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_showConversation) {
            gameRef.player!.idle();
            _showConversation = true;
            _showIntroduction();
          }
        },
        radiusVision: (2 * 32),
      );
    }
  }

  @override
  void render(Canvas canvas) {
    // do anything
    super.render(canvas);
  }

  static Future<SpriteAnimation> idleRight() async {
    return SpriteAnimation.load(
      'Npcs/nurse3_idle.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.2,
        textureSize: Vector2.all(36),
        texturePosition: Vector2(16, 16),
      ),
    );
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(text: 'Oi, tudo bem? Como posso te ajudar?'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/queiroga.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: 'Olá, eu sou o Dr. Gustavo, novo médico do hospital.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/gu.jpeg',
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Ah, seja bem-vindo, Dr. Gustavo. Sou o Dr. Queiroga, responsável pela UTI do hospital.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/queiroga.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
              text:
                  'Muito prazer, Dr. Queiroga. Me disseram que posso pegar a medicação que está sendo dada ao paciente Jairo aqui com você.',
            )
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/gu.jpeg',
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Ah sim, só terei a cloroquina aqui. Mas você pode pegar a ivermectina na enfermagem. Caso já tenha pego, basta voltar a falar com o Pazuello.'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/queiroga.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
              text: 'Ok, muito obrigado!',
            )
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/gu.jpeg',
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
