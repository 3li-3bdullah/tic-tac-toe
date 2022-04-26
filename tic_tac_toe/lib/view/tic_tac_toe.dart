import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe" , style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(child: 
          CustomPaint(painter: ScreenPainter(),)),
          ),
      ),
    );
  }
}