import 'package:flutter/material.dart';
import 'package:axtune/view/widget/button_painter.dart';
import 'package:axtune/view/widget/custom_shape_button.dart';
import 'package:axtune/view/widget/neumorphic_button.dart';
import 'package:axtune/view_models/music_view_model.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    final musicViewModel = context.watch<MusicViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomShapeButton(
          icon: Icons.skip_previous,
          size: 50,
          onTap: () => musicViewModel.skipPrevious(),
        ),
        CustomShapeButton(
          icon: Icons.replay_10,
          onTap: () => musicViewModel.replay(),
        ),
        NeumorphicButton(
          icon: musicViewModel.isPlaying ? Icons.pause : Icons.play_arrow,
          onTap: () => musicViewModel.playPauseMusic(),
          size: 80,
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
        CustomShapeButton(
          icon: Icons.forward_10,
          onTap: () => musicViewModel.forward(),
          flip: Flip.right,
        ),
        CustomShapeButton(
          flip: Flip.right,
          icon: Icons.skip_next,
          size: 50,
          onTap: () => musicViewModel.skipNext(),
        ),
      ],
    );
  }
}
