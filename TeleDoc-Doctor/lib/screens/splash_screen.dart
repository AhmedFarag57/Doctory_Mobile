import 'package:doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:doctor/screens/onboard/on_board_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(
            seconds: 3
        ),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
            OnBoardScreen()
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white,
                  border: Border.all(color: CustomColor.primaryColor.withOpacity(0.4), width: 10)
                ),
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
