import 'package:flutter/material.dart';
import 'package:axtune/view/widget/neumorphic_container.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      shape: BoxShape.circle,
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(70),
      stops: [0.4, 0.5, 0.8, 1],
      colors: [
        Color(0xFFf366f3),
        Color(0xFFf795f7),
        Color(0xFFc40ef9),
        Color(0xFF7b049d),
      ],
      child: Icon(Icons.music_note, size: 100),
    );
  }
}
