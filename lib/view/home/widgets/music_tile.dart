import 'package:flutter/material.dart';
import 'package:axtune/model/music_model.dart';
import 'package:axtune/view/player/player_view.dart';
import 'package:axtune/view/widget/neumorphic_container.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({super.key, required this.music, required this.currentIndex});

  final MusicModel music;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      margin: EdgeInsets.all(10),

      colors: [Color(0xFF15faff), Color(0xFF988ef1)],
      child: ListTile(
        leading: Icon(Icons.music_note),
        title: Text(music.title),
        trailing: Icon(Icons.play_arrow),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerView(index: currentIndex),
            ),
          );
        },
      ),
    );
  }
}
