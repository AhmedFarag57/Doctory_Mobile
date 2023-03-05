import 'package:flutter/material.dart';
import 'package:teledoc/screens/splash_screen.dart';
import 'package:teledoc/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: CustomColor.primaryColor,
          fontFamily: 'Ubuntu'
      ),
      home: SplashScreen(),
    );
  }
  // Samir2
}