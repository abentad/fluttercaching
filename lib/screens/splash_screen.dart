import 'dart:async';

import 'package:autocomplete/screens/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), openOnBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //     "assets/white1.jpg",
            //   ),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: AssetImage(
                  "assets/bg2.png",
                ),
                height: 120.0,
              )
              // SvgPicture.asset(
              //   "assets/burger_logo.svg",
              //   height: 150,
              // ),
              ),
        ),
      ),
    );
  }

  void openOnBoard() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => OnBoardingScreen(),
      ),
    );
  }
}
