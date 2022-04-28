import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  Mark currentMark = Mark.O;
  List<int>? winningLine;
  Map<int, Mark> gameMarks = {};

  void addMark(double x, double y) {
    double divideSize = ScreenPainter.getDivideSize();
    bool isAbsent = false;
    gameMarks.putIfAbsent((x ~/ divideSize + (y ~/ divideSize) * 3).toInt(),
        () {
      isAbsent = true;
      return currentMark;
    });
    if (isAbsent) currentMark = currentMark == Mark.O ? Mark.X : Mark.O;
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuildddddddddddddddddddddddddddddddddd");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pink[500],
      ),
      body: Center(
          child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          setState(() {
            if (gameMarks.length >= 9 || winningLine != null) {
              gameMarks = <int, Mark>{};
              currentMark = Mark.O;
              winningLine = null;
            } else {
              addMark(details.localPosition.dx, details.localPosition.dy);
              winningLine = getWinningLine();
            }
          });
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
              child: CustomPaint(
            painter: ScreenPainter(gameMarks: gameMarks),
          )),
        ),
      )),
    );
  }

  getWinningLine() {
    final winningLines = [
      //Horizontal Lines
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      //Vertical Lines
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      //Diagonal
      [0, 4, 8],
      [2, 4, 6],
    ];

    List<int> winningLineFount;
  }
}

class ScreenPainter extends CustomPainter {
  static double? divideSize;
  Map<int, Mark>? gameMarks;
  ScreenPainter({required this.gameMarks});
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
    final yellowThickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = double_stroke_width
      ..color = Colors.yellow;

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
          drawNought(canvas, index, yellowThickPaint);
          break;
        case Mark.X:
          drawCross(canvas, index, whiteThickPaint);
          break;
        default:
          break;
      }
    });
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

  // Logic
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
}
