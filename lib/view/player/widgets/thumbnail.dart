import 'package:flutter/material.dart';
import 'package:axtune/view/widget/neumorphic_container.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Center(
        child: NeumorphicContainer(
          width: 250,
          height: 250,
          margin: const EdgeInsets.all(20),
          shape: BoxShape.circle,
          child: Icon(Icons.music_video, size: 100, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
