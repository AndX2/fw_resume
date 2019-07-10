import 'package:flutter_web/material.dart';

class Bracket extends StatelessWidget {
  final Color color;
  final double width;
  final BracketType type;

  Bracket({@required this.color, @required this.width, @required this.type});

  @override
  Widget build(BuildContext context) {
    // print('type: $type');
    return LayoutBuilder(
      builder: (context, constraints) => Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: CustomPaint(
              painter: BracketPainter(color: color, width: width, type: type),
            ),
          ),
    );
  }
}

class BracketPainter extends CustomPainter {
  final BracketType type;
  final Color color;
  final double width;
  Paint bPaint;
  BracketPainter(
      {@required this.color, @required this.width, @required this.type}) {
    this.bPaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width;
  }
  @override
  void paint(Canvas canvas, Size size) {
    // print(size);
    switch (type) {
      case BracketType.left:
        canvas.drawLine(Offset(0.0, size.height / 4.0),
            Offset(size.width, size.height / 4.0), bPaint);
        canvas.drawLine(Offset(0.0, size.height / 4.0),
            Offset(0.0, size.height), bPaint);
        break;
      case BracketType.rigth:
        canvas.drawLine(Offset(0.0, size.height / 4.0),
            Offset(size.width, size.height / 4.0), bPaint);
        canvas.drawLine(Offset(size.width, size.height / 4.0),
            Offset(size.width, size.height), bPaint);
        break;
      default:
      // canvas.drawLine(Offset(0.0, size.height / 2.0),
      //   Offset(size.width, size.height / 2.0), bPaint);
    }

    // canvas.drawLine(Offset(0.0, size.height / 2.0),
    //     Offset(size.width, size.height / 2.0), bPaint);
  }

  @override
  bool shouldRepaint(BracketPainter oldDelegate) {
    return true;
  }
}

enum BracketType { left, rigth, bottom, top }
