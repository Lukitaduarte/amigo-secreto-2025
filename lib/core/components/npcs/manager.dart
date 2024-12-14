import 'dart:html' as html;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../player/inventory.dart';
import '../../shared/utils/custom_sprite_animation_widget.dart';

class Manager extends SimpleNpc with ChangeNotifier {
  bool _showConversation = false;
  bool _showOptions = false;
  bool _finish = false;

  late Inventory _doctorInventory;

  Manager(Vector2 position)
      : super(
          position: position, // required
          size: Vector2.all(50), // required
          initDirection: Direction.right,
          animation: SimpleDirectionAnimation(
            idleRight: idleRight(),
            runRight: SpriteAnimation.load(
              'Npcs/manager_idle.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(36),
                texturePosition: Vector2(16, 16),
              ),
            ),
            runUpRight: SpriteAnimation.load(
              'Npcs/manager_idle.png',
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
  void onMount() {
    _doctorInventory = GetIt.instance.get();
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (_finish) {
            PanaraInfoDialog.show(
              gameRef.context,
              title: "Você foi demitido!",
              message: "Parabéns Dr. Gustavo, você fez a coisa certa!",
              buttonText: "Atualize para jogar novamente",
              onTapDismiss: () {
                html.window.location.reload();
              },
              panaraDialogType: PanaraDialogType.success,
              barrierDismissible: false,
            );
          } else if (!_showOptions &&
              _showConversation &&
              _doctorInventory.ivermectina &&
              _doctorInventory.cloroquina) {
            gameRef.player!.idle();
            _showOptions = true;
            _showDialog();
          } else if (!_showConversation) {
            gameRef.player!.idle();
            _showConversation = true;
            _showIntroduction();
            return;
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
      'Npcs/manager_idle.png',
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
            TextSpan(
                text:
                    'Seja bem vindo Dr. Gustavo! Sou o Pazuello, diretor do hospital. Já tenho uma missão para você. Vá até a sala de tomografia e pegue o exame do paciente Jairo.'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Muito prazer Sr. Pazuello, poderia me dizer onde fica a tomografia?')
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
                    'Claro, afinal é seu primeiro dia né? Siga reto esse corredor, a sala de tomografia é a última à esquerda. Não se esqueça, missão dada é missão cumprida!'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  void _showDialog() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(text: 'Ual, você foi bem rápido, conseguiu os exames?.'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Consegui! Mas o paciente não está nada bem, vi que estamos receitando Ivermectina e Cloroquina, mas não me parece correto... Devemos suspender imediatamente ou teremos que intuba-lo, logo logo.'),
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
                    'Essa é a intenção, Dr. Gustavo, UTI lotada é sinal de sucesso! Da muito dinheiro para o hospital!'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Mas Sr. Pazuello, isso está errado, não podemos fazer isso com os pacientes, é antiético!'),
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
                    'Dr. Gustavo, você é novo aqui, não sabe como as coisas funcionam, mas logo logo você se acostuma. Vamos lá, entregue os exames e vá para a UTI, temos muitos pacientes para entubar!'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Não posso fazer isso, Sr. Pazuello, não posso ser cúmplice de algo que vai contra a ética médica!'),
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
                    'Você não tem escolha, Dr. Gustavo, ou faz o que eu mando ou está demitido!'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/pazuello.jpg',
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    'Não posso compactuar com isso, Sr. Pazuello, prefiro ser demitido e irei denúncia-lo!'),
          ],
          person: const CustomSpriteAnimationWidget(
            path: 'assets/images/Avatars/gu.jpeg',
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      onFinish: () {
        _finish = true;
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
