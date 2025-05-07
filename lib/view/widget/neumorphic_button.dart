import 'package:flutter/material.dart';
import 'package:axtune/view/widget/neumorphic_container.dart';

class NeumorphicButton extends StatelessWidget {
  final IconData icon;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onTap;
  final BoxShape? shape;
  final double? size;
  final Color? color;
  const NeumorphicButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.shape,
    this.size,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      shape: shape ?? BoxShape.circle,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: size, color: color),
        ),
      ),
    );
  }
}
