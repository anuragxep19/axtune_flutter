import 'package:flutter/material.dart';
import 'package:axtune/view_models/music_view_model.dart';
import 'package:provider/provider.dart';

class CustomSlider extends StatelessWidget {
  final ValueNotifier<bool> isTapped = ValueNotifier(false);

  CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final musicViewModel = context.watch<MusicViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ), // Small outer spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Current Position Text
          Text(
            musicViewModel.position.inString,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),

          SizedBox(width: 8), // Gap between text and slider
          // Slider
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                value: musicViewModel.sliderValue,
                onChanged: (value) => musicViewModel.seekTo(value),
                activeColor: Colors.black,
                inactiveColor: Colors.grey.shade300,
              ),
            ),
          ),

          SizedBox(width: 8), // Gap between slider and duration
          // Duration / Remaining Toggle
          ValueListenableBuilder<bool>(
            valueListenable: isTapped,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () => isTapped.value = !value,
                child: Text(
                  value
                      ? "-${musicViewModel.remaining}"
                      : musicViewModel.duration.inString,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
