// import 'dart:math';

import './pentagon_outline.dart';
export './pentagon_outline.dart' ;

import 'package:flutter_web/material.dart';

import './pentagon_util.dart';

class Pentagon extends StatelessWidget {
  final double borderWidth;
  final Color color;
  final Color shadowColor;
  final Widget child;
  final double radius;
  final double elevation;

  Pentagon(
      {@required this.color,
      this.shadowColor = Colors.black,
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
            painter: ShadowPainter(
                color: shadowColor, radius: radius, elevation: elevation),
          ),
        ),
        Positioned.fill(
          child: ClipPath(
            clipper: Clipper(radius),
            child: Container(
              color: color,
            ),
          ),
        ),
        (child != null)
            ? Positioned.fill(
                child: (borderWidth > .0)
                    ? Padding(
                        padding: EdgeInsets.all(borderWidth),
                        child: ClipPath(
                          clipper: Clipper(radius),
                          child: child,
                        ),
                      )
                    : ClipPath(
                        clipper: Clipper(radius),
                        child: child,
                      ),
              )
            : Container()
      ],
    );
  }
}

class ShadowPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double elevation;
  ShadowPainter(
      {this.color = Colors.black, this.radius = 1.0, this.elevation = 4.0});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(buildClip(size, radius), color, elevation, true);
  }

  @override
  bool shouldRepaint(ShadowPainter oldDelegate) {
    return true;
  }
}

class Clipper extends CustomClipper<Path> {
  final double radius;
  Clipper(this.radius);
  @override
  Path getClip(Size size) {
    return buildClip(size, radius);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
