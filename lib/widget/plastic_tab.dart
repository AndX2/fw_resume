import 'package:flutter_web/material.dart';
import 'dart:math';

class PlasticTab extends StatelessWidget {
  final Widget child;
  final Color color;

  PlasticTab({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ClipPath(
            clipper: TabClipper(),
            child: Container(color: Colors.amber),
          ),
        )
      ],
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width * .9, size.height);
    path.arcToPoint(Offset(size.width, size.height - size.width * .1),
    radius: Radius.circular(size.width *.1), clockwise: false
        // rotation: pi * .5, clockwise: false
        );
    path.lineTo(size.width, size.height - 100.0);
    path.cubicTo(
        size.width,
        size.height - 100.0 - size.width * .2,
        size.width * .8,
        size.height - 100.0,
        size.width * .8,
        size.height - 100.0 - size.width * .2);
    path.lineTo(size.width * .8, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) {
    return false;
  }
}
