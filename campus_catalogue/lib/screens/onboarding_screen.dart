import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 82, 30, 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.backgroundOrange,
                  ),
                  child: Image.asset("assets/onboarding_image.png")),
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Lazy morning or a busy day?",
                style: AppTypography.textMd.copyWith(fontSize: 16)),
            const SizedBox(
              height: 4,
            ),
            Text(
                "Want to avoid queue and experience a \nhustle-free ordering journey.",
                textAlign: TextAlign.center,
                style: AppTypography.textMd.copyWith(fontSize: 12)),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF57C51),
                      ),
                      child: Center(
                        child: Text("Get Started", style: AppTypography.textMd),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
