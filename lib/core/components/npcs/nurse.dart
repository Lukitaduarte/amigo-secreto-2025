import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/utils/custom_sprite_animation_widget.dart';

class Nurse extends SimpleNpc {
  bool _showConversation = false;

  Nurse(Vector2 position)
      : super(
          position: position, // required
          size: Vector2.all(50), // required
          initDirection: Direction.right,
          animation: SimpleDirectionAnimation(
            idleRight: idleRight(),
            runRight: SpriteAnimation.load(
              'Npcs/nurse1_idle.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(36),
                texturePosition: Vector2(16, 16),
              ),
            ),
            runUpRight: SpriteAnimation.load(
              'Npcs/nurse1_idle.png',
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
      'Npcs/nurse1_idle.png',
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
            path: 'assets/images/Avatars/michelle.jpg',
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
                    'Seja bem-vindo, Dr. Gustavo. Me chamo Michelle, sou a responsável por essa enfermagem.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/michelle.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
              text:
                  'Muito prazer, Michelle. Me disseram que poderia pegar a medicação que está sendo receitada ao paciente Jairo aqui com você.',
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
                    'Ah sim, você pode pegar a ivermectina que está ali em cima do balcão. Já a cloroquina você terá que ir até a UTI, é a sala em frente a tomografia.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/michelle.jpg',
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
