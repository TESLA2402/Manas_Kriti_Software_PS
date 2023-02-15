import 'dart:async';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF6),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash_screen.png",
              height: 160,
              width: 160,
            ),
            Text("Explore IITG",
                style: AppTypography.textMd.copyWith(
                    color: const Color(0xFFFC8019),
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
