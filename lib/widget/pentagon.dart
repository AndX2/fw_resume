import 'dart:math';
import 'package:flutter_web/material.dart';

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
      this.radius,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    print(shadowColor);
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: ShadowPainter(color: shadowColor),
          ),
        ),
        Positioned.fill(
          child: ClipPath(
            clipper: Clipper(),
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
                          clipper: Clipper(),
                          child: child,
                        ),
                      )
                    : ClipPath(
                        clipper: Clipper(),
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
  ShadowPainter({this.color}) {
    color ?? Colors.black;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(_buildClip(size), color, 16.0, true);
  }

  @override
  bool shouldRepaint(ShadowPainter oldDelegate) {
    return true;
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return _buildClip(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Path _cachedPath;
Size _cashedSize;

Path _buildClip(Size size) {
  if (size == _cashedSize && _cachedPath != null) return _cachedPath;
  var path = Path();
  var r = 50.0;
  final count = 5;
  final angle = (count - 2) / count; //(.6*pi)
  final baseAngle = .5 + 2.0 / count; //(0.9*pi)
  final h = size.height;
  final w = size.width;
  final mS = (w > h) ? h : w;
  final a = mS / (2 * sin(.3 * pi));
  if (r > a / 2) r = a / 2;
  final h5 = a * (cos(.3 * pi) + cos(.1 * pi));
  final ph = (h - h5) / 2;
  final pw = (w - a * 2 * sin(.3 * pi)) / 2;
  final outRectOffset = Offset(pw, ph);
  final offsets = List<Offset>();
  offsets.add(outRectOffset + Offset(0.0, a * cos(.3 * pi)));
  offsets.add(outRectOffset + Offset(a * sin(.1 * pi), mS - 2 * ph));
  offsets.add(outRectOffset + Offset(mS - a * sin(.1 * pi), mS - 2 * ph));
  offsets.add(outRectOffset + Offset(mS, a * cos(.3 * pi)));
  offsets.add(outRectOffset + Offset(mS / 2, 0.0));
  final c1 = outRectOffset + Offset(0.0, a * cos(.3 * pi));
  final c2 = outRectOffset + Offset(a * sin(.1 * pi), mS - 2 * ph);
  final c3 = outRectOffset + Offset(mS - a * sin(.1 * pi), mS - 2 * ph);
  final c4 = outRectOffset + Offset(mS, a * cos(.3 * pi));
  final c5 = outRectOffset + Offset(mS / 2, 0.0);
  final ad = r / tan(.3 * pi);
  final wa = ad * sin(.3 * pi);
  final ha = ad * cos(.3 * pi);
  // path.addPolygon([c1, c2, c3, c4, c5], true);
  final index = 0;
  // path.moveTo(c1.dx + ad * cos(.2 * pi), c1.dy - ad * sin(.2 * pi));
  path.moveTo(c1.dx - ad * cos((baseAngle + angle / 2) * pi),
      c1.dy + ad * sin((baseAngle + angle / 2) * pi));
  // path.lineTo(c1.dx + ad * cos(-.4 * pi), c1.dy - ad * sin(-.4 * pi));
  // for (int index = 0; index < count; index++) {
  //   path.arcToPoint(
  //       Offset(
  //           offsets[index].dx -
  //               ad * cos((baseAngle + .4 * index - angle / 2) * pi),
  //           offsets[index].dy +
  //               ad * sin((baseAngle + .4 * index - angle / 2) * pi)),
  //       radius: Radius.circular(r),
  //       clockwise: true);
  //   path.lineTo(
  //       offsets[index].dx -
  //           ad * cos((baseAngle + .4 * index + angle / 2) * pi),
  //       offsets[index].dy +
  //           ad * sin((baseAngle + .4 * index + angle / 2) * pi));
  // }
  path.arcToPoint(
      Offset(c1.dx - ad * cos((baseAngle - angle / 2) * pi),
          c1.dy + ad * sin((baseAngle - angle / 2) * pi)),
      radius: Radius.circular(r),
      clockwise: false);
  // path.lineTo(c2.dx, c2.dy);
  path.lineTo(c2.dx - ad * cos((baseAngle + .4 + angle / 2) * pi),
      c2.dy + ad * sin((baseAngle + .4 + angle / 2) * pi));
  path.arcToPoint(
      Offset(c2.dx - ad * cos((baseAngle + .4 - angle / 2) * pi),
          c2.dy + ad * sin((baseAngle + .4 - angle / 2) * pi)),
      radius: Radius.circular(r),
      clockwise: false);
  path.lineTo(c3.dx - ad * cos((baseAngle + .8 + angle / 2) * pi),
      c3.dy + ad * sin((baseAngle + .8 + angle / 2) * pi));
  path.arcToPoint(
      Offset(c3.dx - ad * cos((baseAngle + .8 - angle / 2) * pi),
          c3.dy + ad * sin((baseAngle + .8 - angle / 2) * pi)),
      radius: Radius.circular(r),
      clockwise: false);
  // path.lineTo(c3.dx, c3.dy);
  path.lineTo(c4.dx - ad * cos((baseAngle + 1.2 + angle / 2) * pi),
      c4.dy + ad * sin((baseAngle + 1.2 + angle / 2) * pi));
  path.arcToPoint(
      Offset(c4.dx - ad * cos((baseAngle + 1.2 - angle / 2) * pi),
          c4.dy + ad * sin((baseAngle + 1.2 - angle / 2) * pi)),
      radius: Radius.circular(r),
      clockwise: false);
  // path.lineTo(c4.dx, c4.dy);
  path.lineTo(c5.dx + wa, c5.dy + ha);
  path.arcToPoint(Offset(c5.dx - wa, c5.dy + ha),
      radius: Radius.circular(r), clockwise: false);
  path.close();
  // path.lineTo(0.0, size.height);
  // path.lineTo(size.width * 0.2, size.height);
  // path.cubicTo(
  //     size.width * .23,
  //     size.height,
  //     size.width * 0.22,
  //     size.height - size.width * .05,
  //     size.width * .25,
  //     size.height - size.width * .05);
  // path.lineTo(size.width, size.height - size.width * .05);
  // path.lineTo(size.width, 0.0);
  // path.close();
  _cachedPath = path;
  return path;
}
