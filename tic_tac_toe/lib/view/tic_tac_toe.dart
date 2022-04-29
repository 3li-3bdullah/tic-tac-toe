import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/view/tic_tac_toe_widgets/screen_painter.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

// ignore: must_be_immutable
class _TicTacToeState extends State<TicTacToe> {
  // Declaring variables .
  Mark currentMark = Mark.O;
  List<int>? winningLine;
  Map<int, Mark> gameMarks = {};
  bool isWinning = false;

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
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails details) {
            setState(
              () {
                if (gameMarks.length >= 9 || winningLine != null) {
                  gameMarks = <int, Mark>{};
                  currentMark = Mark.O;
                  winningLine = null;
                  isWinning = false;
                } else {
                  addMark(details.localPosition.dx, details.localPosition.dy);
                  winningLine = getWinningLine();
                }
              },
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: CustomPaint(
                  painter: ScreenPainter(
                      gameMarks: gameMarks, winningLine: winningLine),
                ),
              ),
              isWinning
                  ? Center(
                      child: Lottie.asset("assets/congrats.json"),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  // All methods .
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

  // Here to get where fields they should have the winning line .
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

    List<int>? winningLineFount;
    for (var items in winningLines) {
      int countNoughts = 0;
      int countCrosses = 0;

      for (var index in items) {
        if (gameMarks[index] == Mark.O) {
          ++countNoughts;
        } else if (gameMarks[index] == Mark.X) {
          ++countCrosses;
        }
      }
      if (countNoughts >= 3 || countCrosses >= 3) {
        winningLineFount = items;
        setState(() {
          isWinning = true;
        });
      }
    }

    return winningLineFount;
  }
}
