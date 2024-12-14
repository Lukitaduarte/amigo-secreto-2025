import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/utils/custom_sprite_animation_widget.dart';

class Nurse2 extends SimpleNpc {
  bool _showConversation = false;

  Nurse2(Vector2 position)
      : super(
          position: position, // required
          size: Vector2.all(50), // required
          initDirection: Direction.up,
          animation: SimpleDirectionAnimation(
            idleRight: idleRight(),
            idleDown: idleRight(),
            runRight: SpriteAnimation.load(
              'Npcs/nurse2_idle.png',
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

  static Future<SpriteAnimation> idleRight() async {
    return SpriteAnimation.load(
      'Npcs/nurse2_idle.png',
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
            path: 'assets/images/Avatars/nise.webp',
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
                    'Ah, seja bem-vindo, Dr. Gustavo. Me chamo Dra. Nise Yamaguchi, sou a responsável pela tomografia.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/nise.webp',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
              text:
                  'Muito prazer,  Dra. Yamaguchi. Me pediram pra vir checar o resultado do exame do Sr. Jairo que está com covid.',
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
                    'Ah, acabou de sair, ele não está nada bem, acho que devemos aumentar as doses de cloroquina e ivermectina dele.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/nise.webp',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
              text:
                  'Hmmm, onde posso encontrar esses medicamentos? Irei averiguar isso pessoalmente...',
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
                    'Na enfermagem, a sala a esquerda dessa, basta voltar ao corredor.')
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/nise.webp',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
