import 'dart:math';
import 'package:flutter_web/material.dart';


class SkillArcPainter extends CustomPainter {
  final double screenScale;
  double countScale;
  final double value;
  Paint _paint;

  SkillArcPainter(
      {@required this.value,
      @required this.screenScale,
      @required Color color,
      this.countScale = 1}) {
    double width = 16.0 * screenScale * countScale;
    _paint = Paint()
      ..color = color
      ..strokeWidth = width > 8.0 ? 8.0 : 16.0 * screenScale * countScale
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(0.0, 0.0) & size;
    canvas.drawArc(rect, 0.0, 2 * pi * value, false, _paint);
  }

  @override
  bool shouldRepaint(SkillArcPainter oldDelegate) {
    return false;
  }
}
