import 'package:flutter/material.dart';
import 'package:axtune/view/player/widgets/about_bottom_sheet.dart';
import 'package:axtune/view/widget/neumorphic_button.dart';
import 'package:axtune/view_models/music_view_model.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final musicModelView = context.watch<MusicViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          NeumorphicButton(
            shape: BoxShape.rectangle,
            icon: Icons.arrow_back_ios_new,
            size: 24,
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 5),
          // const Spacer(flex: 1),

          // Title in Flexible to avoid overflow
          Flexible(
            child: Text(
              musicModelView.currentMedia?.title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),

          SizedBox(width: 5), //  const Spacer(flex: 1),
          NeumorphicButton(
            shape: BoxShape.rectangle,
            icon: Icons.info_outline,
            size: 24,
            onTap: () => showMusicInfoSheet(context),
          ),
        ],
      ),
    );
  }
}
