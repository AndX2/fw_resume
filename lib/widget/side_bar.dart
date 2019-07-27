import 'package:flutter_web/material.dart';
import 'dart:math';

class SideBar extends StatelessWidget {
  final Widget child;
  final Color color;

  SideBar({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Transform.translate(
            offset: Offset(-30.0, -70.0),
            child: ClipPath(
              clipper: LeftSideClipper(),
              child: Container(
                color: Color(0xFF53C5F9),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: ClipPath(
            clipper: LeftSideClipper(),
            child: Container(
              color: Color(0xFF00569C),
              child: Padding(
                padding: const EdgeInsets.only(top: 400.0),
                child: child ?? Container(),
              ),
            ),
            //  Color(0xFF53C5F9)
          ),
        )
      ],
    );
  }
}

double _topPadding = 140.0;
double _pentaAngle = ((5 - 2) * pi) / 5.0;
double _clipperHeight = 800.0;

class LeftSideClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // print(size);
    var path = Path();
    path.moveTo(0.0, _topPadding);
    path.lineTo(size.width,
        _topPadding + tan(pi * (.5) - _pentaAngle / 2.0) * size.width);
    path.lineTo(size.width, _topPadding + _clipperHeight);
    path.lineTo(
        0.0,
        _topPadding +
            _clipperHeight +
            tan(pi * (.5) - _pentaAngle / 2.0) * size.width);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
