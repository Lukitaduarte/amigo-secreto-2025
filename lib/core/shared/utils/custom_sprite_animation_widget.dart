import 'package:flutter/material.dart';

class CustomSpriteAnimationWidget extends StatelessWidget {
  final String path;

  const CustomSpriteAnimationWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(path),
    );
  }
}
