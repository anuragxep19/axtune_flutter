import 'package:flutter/material.dart';
import 'package:axtune/model/music_model.dart';
import 'package:axtune/view/home/widgets/music_tile.dart';
import 'package:axtune/view/widget/neumorphic_container.dart';
import 'package:axtune/view_models/music_view_model.dart';
import 'package:provider/provider.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<MusicViewModel>().loadMusics(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final musicList = snapshot.data as List<MusicModel>;
        return NeumorphicContainer(
          startOffset: Offset(5, -5),
          endOffset: Offset(-5, 5),
          colors: [Color(0xFF988ef1), Color(0xFF15faff)],
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return MusicTile(music: musicList[index], currentIndex: index);
            },
          ),
        );
      },
    );
  }
}
