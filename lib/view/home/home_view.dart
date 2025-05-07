import 'package:flutter/material.dart';
import 'package:axtune/view/home/widgets/custom_drawer.dart';
import 'package:axtune/view/home/widgets/heading.dart';
import 'package:axtune/view/home/widgets/music_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 32.0),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: CustomDrawer(),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 0.3, 0.6, 1],
                colors: [
                  Color(0xFFe211e1),
                  Color(0xFFc40ef9),
                  Color(0xFF988ef1),
                  Color(0xFF15faff),
                ],
              ),
            ),

            child: Column(children: [Heading(), Expanded(child: MusicList())]),
          ),
        ],
      ),
    );
  }
}
