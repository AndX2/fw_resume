import 'package:flutter_web/material.dart';


class BarShadowPainter extends CustomPainter {
  final double elevation;
  final Color color;
  final double shrinkScale;
  BarShadowPainter(
      {@required this.shrinkScale,
      @required this.color,
      @required this.elevation});
  @override
  void paint(Canvas canvas, Size size) {
    final startHeight = (.1 + .2 * shrinkScale) * size.width;
    final path = Path();
    path.lineTo(.0, startHeight);
    path.quadraticBezierTo(size.width / 2.0,
        size.width * .45 * (.1 + shrinkScale), size.width, startHeight);
    path.lineTo(size.width, .0);
    path.close();
    canvas.drawShadow(path, color, elevation, true);
  }

  @override
  bool shouldRepaint(BarShadowPainter oldDelegate) {
    return true;
  }
}

class BarClipper extends CustomClipper<Path> {
  final curveBarHeight = .25;
  final curveBarWidth = .8;
  final leftPadding = .25;
  final shrinkScale;
  BarClipper({@required this.shrinkScale});
  @override
  Path getClip(Size size) {
    final startHeight = (.1 + .2 * shrinkScale) * size.width;
    final path = Path();
    path.lineTo(.0, startHeight);
    path.quadraticBezierTo(size.width / 2.0,
        size.width * .45 * (.1 + shrinkScale), size.width, startHeight);
    path.lineTo(size.width, .0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BarClipper oldClipper) {
    return true;
  }
}


