import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';

class ScreenPainter extends CustomPainter {
  static double? divideSize;
  @override
  void paint(Canvas canvas, Size size) {
    final customPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke_width
      ..color = Colors.white;
    divideSize = size.width / 3;
    //First Horizontal Line --
    canvas.drawLine(Offset(stroke_width, divideSize! - half_stroke_width),
        Offset(size.width, divideSize! - half_stroke_width), customPaint);
    //First Vertical Line |
    canvas.drawLine(Offset(divideSize! - half_stroke_width, stroke_width),
        Offset(divideSize! - half_stroke_width, size.height), customPaint);
    //Second Horizontal Line --
    canvas.drawLine(Offset(stroke_width, divideSize! * 2.0 - half_stroke_width),
        Offset(size.width, divideSize! * 2.0 - half_stroke_width), customPaint);
    //Second vertical Line |
    canvas.drawLine(Offset( divideSize! * 2.0 - half_stroke_width , stroke_width),
        Offset(divideSize! * 2.0 - half_stroke_width , size.height), customPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static double getDivideSize() => divideSize!;
}
