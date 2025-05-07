import 'package:flutter/material.dart';
import 'package:axtune/view/widget/button_painter.dart';

class CustomShapeButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? borderColor;
  final Flip? flip;
  final double? size;
  final VoidCallback onTap;
  const CustomShapeButton({
    super.key,
    required this.icon,
    this.flip,
    this.size,
    required this.onTap,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CustomPaint(
        painter: ButtonPainter(
          flip: flip,
          color: borderColor ?? Colors.grey.shade300,
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: CustomShapeBorder(clipper: ButtonClipper(flip: flip)),
          child: Icon(
            icon,
            size: size ?? 80,
            color: iconColor ?? Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  final CustomClipper<Path> clipper;

  const CustomShapeBorder({required this.clipper});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return clipper.getClip(rect.size);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return clipper.getClip(rect.size);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder(clipper: clipper);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
