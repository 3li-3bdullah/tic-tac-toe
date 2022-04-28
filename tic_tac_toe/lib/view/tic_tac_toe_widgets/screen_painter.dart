import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';

class ScreenPainter extends CustomPainter {
  ScreenPainter(
      {required this.gameMarks , required this.winningLine});
  static double? divideSize;
  Map<int, Mark>? gameMarks;
  List<int>? winningLine;
  @override
  void paint(Canvas canvas, Size size) {
    divideSize = size.width / 3;
    final customPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke_width
      ..color = Colors.white;
    final whiteThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = double_stroke_width
      ..color = Colors.white;
      final greyThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = double_stroke_width
      ..color = Colors.grey;
    final winningLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = double_stroke_width
      ..color = Colors.white;

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
    canvas.drawLine(
        Offset(divideSize! * 2.0 - half_stroke_width, stroke_width),
        Offset(divideSize! * 2.0 - half_stroke_width, size.height),
        customPaint);

  
    gameMarks!.forEach((index, mark) {
    switch (mark) {
      case Mark.O:
        drawNought(canvas, index, whiteThickPaint);
        break;
      case Mark.X:
        drawCross(canvas, index, greyThickPaint);
        break;
      default:
        break;
    }
    });
    drawWinningLine(canvas, winningLine, winningLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static double getDivideSize() => divideSize!;

  // This methods to paint the circular shape
  void drawNought(Canvas canvas, int index, Paint paint) {
    double left = (index % 3) * divideSize! + double_stroke_width * 2;
    double top = (index ~/ 3) * divideSize! + double_stroke_width * 2;
    double noughtSize = divideSize! - double_stroke_width * 4;
    canvas.drawOval(Rect.fromLTWH(left, top, noughtSize, noughtSize), paint);
  }

  void drawCross(Canvas canvas, int index, Paint paint) {
    double x1, y1;
    double x2, y2;
    x1 = (index % 3) * divideSize! + double_stroke_width * 2;
    y1 = (index ~/ 3) * divideSize! + double_stroke_width * 2;
    x2 = (index % 3 + 1) * divideSize! - double_stroke_width * 2;
    y2 = (index ~/ 3 + 1) * divideSize! - double_stroke_width * 2;
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

    x1 = (index % 3 + 1) * divideSize! - double_stroke_width * 2;
    y1 = (index ~/ 3) * divideSize! + double_stroke_width * 2;
    x2 = (index % 3) * divideSize! + double_stroke_width * 2;
    y2 = (index ~/ 3 + 1) * divideSize! - double_stroke_width * 2;
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  drawWinningLine(Canvas canvas, List<int>? winningLine , Paint paint) {
    if (winningLine == null) {
      return;
    }
    double x1 = 0, y1 = 0;
    double x2 = 0, y2 = 0;
    int firstIndex = winningLine.first;
    int lastIndex = winningLine.last;

    if (firstIndex % 3 == lastIndex % 3) {
      //Vertical Lines
      x1 = x2 = firstIndex % 3 * divideSize! + divideSize! / 2;
      y1 = stroke_width;
      y2 = divideSize! * 3 - stroke_width;
    } else if (firstIndex ~/ 3 == lastIndex ~/ 3) {
      //Horizontal Lines
      x1 = stroke_width;
      x2 = divideSize! * 3 - stroke_width;
      y1 = y2 = firstIndex ~/ 3 * divideSize! + divideSize! / 2;
    } else {
      if (firstIndex == 0) {
        x1 = y1 = double_stroke_width;
        x2 = y2 = divideSize! * 3 - double_stroke_width;
      } else {
        x1 = divideSize! * 3 - double_stroke_width;
        y1 = double_stroke_width;
        x2 = double_stroke_width;
        y2 = divideSize! * 3 - double_stroke_width;
      }
    }
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }
}
