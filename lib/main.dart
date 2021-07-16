import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Icon(
          Icons.wb_sunny,
          size: 80.0,
          color: Color(0xFF624885),
        ),
        nextScreen: Climate(),
        duration: 2000,

        backgroundColor: Color(0xFF111328),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

class Climate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
