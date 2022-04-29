import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/view/tic_tac_toe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: AnimatedSplashScreen(
            splash: Center(
              child: Text(
                "Tic Tac Toe",
                style: TextStyle(
                    fontFamily: 'Updock', fontSize: 50, color: Colors.black),
              ),
            ),
            nextScreen: const TicTacToe(),
            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Colors.white));
  }
}
