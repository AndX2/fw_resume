import 'dart:math';

import 'package:flutter_web/material.dart';

import './pentagon_util.dart';

class PentagonOutline extends StatelessWidget {
  final double borderWidth;
  final Color color;
  // final Color shadowColor;
  final Widget child;
  final double radius;
  final double elevation;

  PentagonOutline(
      {@required this.color,
      // this.shadowColor = Colors.black,
      this.borderWidth = 1.0,
      this.child,
      this.radius = 1.0,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _PentagonPainter(
                color: color, borderWidth: borderWidth, radius: radius),
          ),
        )
      ],
    );
    // Container();
  }
}

class _PentagonPainter extends CustomPainter {
  double radius;
  final Color color;
  final double borderWidth;
  Paint borderPaint;

  _PentagonPainter(
      {@required this.color,
      @required this.borderWidth,
      @required this.radius}) {
    this.borderPaint = Paint()
      ..color = color
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //TODO: draw outline with drawLines and drawArcs
    canvas.drawPath(buildClip(size, radius), borderPaint);
  }

  @override
  bool shouldRepaint(_PentagonPainter oldDelegate) {
    return true;
  }
}
