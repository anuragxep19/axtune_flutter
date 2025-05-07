import 'package:flutter/material.dart';
import 'package:axtune/view/player/widgets/custom_slider.dart';
import 'package:axtune/view/player/widgets/header.dart';
import 'package:axtune/view/player/widgets/thumbnail.dart';
import 'package:axtune/view/player/widgets/tool_bar.dart';
import 'package:axtune/view_models/music_view_model.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  final int index;
  const PlayerView({super.key, required this.index});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late MusicViewModel musicViewModel;
  @override
  void initState() {
    super.initState();
    musicViewModel = context.read<MusicViewModel>();
    musicViewModel.initializeMusic(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) => musicViewModel.back(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF0F0F3), Color(0xFFE0E0E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Header(),

                Thumbnail(),

                // Playback progress slider
                CustomSlider(),
                // Tool bar
                Expanded(flex: 2, child: ToolBar()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
