import 'package:app/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'assets/images/drabble.png',
        home: MyApp(),
        duration: 3000,
        type: AnimatedSplashType.StaticDuration,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drabble',
      theme: ThemeData(
        backgroundColor: Color(0xFF2C3D63),
        primaryColor: Color(0xFFF7F8F3),
        accentColor: Color(0xFFFF6F5E),
      ),
      home: Auth(),
    );
  }
}
