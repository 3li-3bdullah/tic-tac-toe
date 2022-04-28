import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants.dart';


class TicTacToe extends StatefulWidget {
   const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  Mark currentMark = Mark.O;

  Map<int,Mark> gameMarks = {};

  void addMark(double x , double y){
   double divideSize = ScreenPainter.getDivideSize();
   bool isAbsent = false;
   gameMarks.putIfAbsent(
    (x ~/ divideSize + (y ~/ divideSize) * 3).toInt(),
    () {
      isAbsent = true ; return currentMark;
   }
   );
   if(isAbsent) currentMark = currentMark == Mark.O ? Mark.X : Mark.O;
 }

  @override
  Widget build(BuildContext context) {
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
                  if (gameMarks.length >= 9 ) {
                    gameMarks = <int, Mark>{};
                    currentMark = Mark.O;
                  } else {
                   addMark(details.localPosition.dx, details.localPosition.dy);
                  }
                },
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                      child: CustomPaint(
                    painter: ScreenPainter(gameMarks: gameMarks),
                  )),
                ),
              )
              ),
    );
  }
}
