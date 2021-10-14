import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vanam_social/constants.dart';

class DottedCircularView extends StatelessWidget {
  final Color color;
  final double size;
  final double width;
  final Widget child;

  const DottedCircularView({Key? key, this.color = kPrimaryColor, this.size = 56, this.width = 2.0,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child == null ? Container() : Positioned(
            left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: child),
          CustomPaint(
            size: Size(size, size),
            foregroundPainter: new MyPainter(
                completeColor: color,
                width: width),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor =  Colors.transparent;
  Color completeColor;
  double width;
  MyPainter(
      {required this.completeColor,required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width *0.001) / 2;

    double arcAngle = 4 * pi * percent;
    print("$radius - radius");
    print("$arcAngle - arcAngle");
    print("${radius / arcAngle} - divider");

    for (var i = 0; i < 16; i++) {
      var init = (-pi / 2)*(i/2);

      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
          init, arcAngle, false, complete);
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

