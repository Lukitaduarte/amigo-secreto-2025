import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'core/components/items/cloroquina.dart';
import 'core/components/items/ivermectina.dart';
import 'core/components/npcs/manager.dart';
import 'core/components/npcs/nurse.dart';
import 'core/components/npcs/nurse2.dart';
import 'core/components/npcs/nurse3.dart';
import 'core/components/npcs/receptionist.dart';
import 'core/player/doctor.dart';
import 'core/player/interface.dart';
import 'core/player/inventory.dart';

void main() {
  GetIt.instance.registerLazySingleton<Inventory>(() => Inventory());
  runApp(const MyApp());
}

const tileSize = 32.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      // showCollisionArea: true,
      // debugMode: true,
      playerControllers: [
        Joystick(
          directional: JoystickDirectional(),
        ),
        Keyboard(
          config: KeyboardConfig(
            directionalKeys: [
              KeyboardDirectionalKeys.arrows(),
              KeyboardDirectionalKeys.wasd(),
            ],
            acceptedKeys: [
              LogicalKeyboardKey.space,
            ],
          ),
        )
      ],
      map: WorldMapByTiled(
        WorldMapReader.fromAsset('hospital.tmj'),
        objectsBuilder: {
          'Receptionist': (props) => Receptionist(props.position),
          'Doctor': (props) => Manager(props.position),
          'Nurse': (props) => Nurse(props.position),
          'Nurse2': (props) => Nurse2(props.position),
          'Nurse3': (props) => Nurse3(props.position),
          'Cloroquina': (props) => Cloroquina(props.position),
          'Ivermectina': (props) => Ivermectina(props.position),
          // 'walls': (props) => Walls(props.position),
        },
      ),
      player: DoctorPlayer(
        position: Vector2(tileSize * 3, tileSize * 18),
      ),
      overlayBuilderMap: {
        'player_interface': ((context, game) => PlayerInterface(game))
      },
      initialActiveOverlays: const ['player_interface'],
      cameraConfig: CameraConfig(
        zoom: getZoomFromMaxVisibleTile(context, tileSize, 20),
        initPosition: Vector2(tileSize * 5, tileSize * 5),
      ),
    );
  }
}
