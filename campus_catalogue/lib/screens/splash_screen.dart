import 'dart:async';

import 'package:campus_catalogue/upi_india.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UpiScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash_screen.png",
              height: 100,
              width: 100,
            ),
            const Text(
              "Xplore IITG",
              style: TextStyle(
                  fontFamily: 'Fira Sans',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
