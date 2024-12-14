import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'inventory.dart';

class PlayerInterface extends StatefulWidget {
  final BonfireGame game;

  const PlayerInterface(this.game, {super.key});

  @override
  State<PlayerInterface> createState() => _PlayerInterfaceState();
}

class _PlayerInterfaceState extends State<PlayerInterface> {
  late Inventory inventory;

  @override
  void initState() {
    inventory = GetIt.instance.get();
    (widget.game.player as ChangeNotifier?)?.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    (widget.game.player as ChangeNotifier?)?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.6),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Inventário:'),
            const SizedBox(height: 6),
            ListenableBuilder(
              listenable: inventory,
              builder: (context, child) {
                final hasIvermectina = inventory.ivermectina;
                final hasCloroquina = inventory.cloroquina;

                if (!hasIvermectina && !hasCloroquina) {
                  return const Text('Você não possui itens...');
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(
                    //   width: 24,
                    //   height: 24,
                    //   child: DecorationSpriteSheet.key.asWidget(),
                    // ),
                    const SizedBox(height: 6),
                    if (hasIvermectina) ...[
                      TextButton.icon(
                        icon: const Icon(Icons.check_box, color: Colors.green),
                        label: const Text('Ivermectina'),
                        onPressed: null,
                        // style: const TextStyle(
                        //   color: Colors.white,
                        //   fontSize: 20,
                        // ),
                      ),
                      const SizedBox(height: 6),
                    ],

                    if (hasCloroquina)
                      TextButton.icon(
                        icon: const Icon(Icons.check_box, color: Colors.green),
                        label: const Text('Cloroquina'),
                        onPressed: null,
                        // style: const TextStyle(
                        //   color: Colors.white,
                        //   fontSize: 20,
                        // ),
                      ),
                    if (hasIvermectina && hasCloroquina)
                      const Text(
                        'Você já possui todos os itens, vá falar com o Pazuello!',
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _listener() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
