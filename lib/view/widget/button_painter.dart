import 'package:flutter/material.dart';

class ButtonPainter extends CustomPainter {
  final Flip? flip;
  final Color? color;
  final double? strokeWidth;

  ButtonPainter({this.color, this.strokeWidth, this.flip = Flip.left});
  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint =
        Paint()
          ..color = color ?? Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth ?? 4;
    Path path = _getPath(size);
    if (flip == Flip.right) path = _rotatePath(path, size);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ButtonClipper extends CustomClipper<Path> {
  final Flip? flip;

  ButtonClipper({super.reclip, this.flip = Flip.left});
  @override
  getClip(Size size) {
    Path path = _getPath(size);

    if (flip == Flip.right) path = _rotatePath(path, size);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

enum Flip { left, right }

Path _rotatePath(Path path, Size size) {
  final matrix =
      Matrix4.identity()
        ..translate(size.width / 2, size.height / 2)
        ..rotateZ(3.14159) // 180 degrees in radians
        ..translate(-size.width / 2, -size.height / 2);

  path = path.transform(matrix.storage); // Apply the transformation
  return path;
}

Path _getPath(Size size) {
  double extraWidth = size.width / 2;
  return Path()
    ..moveTo(size.width, 0)
    ..arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.elliptical(size.width * 2, size.height),
      clockwise: false,
    )
    ..lineTo(size.width - extraWidth, size.height)
    ..arcToPoint(
      Offset(size.width - extraWidth, 0),
      radius: Radius.circular((size.width - extraWidth) / 2),
      clockwise: true,
    )
    ..close();
}
