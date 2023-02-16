import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/screens/home_screen.dart';
import 'package:campus_catalogue/screens/sign_in.dart';
import 'package:campus_catalogue/screens/userType_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFC8019)),
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFFFFF2E0)),
    );
    var code = "";
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 64, 20, 36),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xFFFC8019),
                  )),
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              "OTP Verification",
              style: AppTypography.textMd
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Enter the four digit code which has been \nsent to your mobile number +91xxxxxxxxxx.",
              style: AppTypography.textSm.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                onCompleted: (value) {
                  code = value;
                }),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Text(
                  "Resend OTP",
                  style: AppTypography.textSm.copyWith(fontSize: 14),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: SignIn.verify, smsCode: code);
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserType()),
                  );
                } catch (e) {
                  print("wrong OTP");
                }
              },
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
                        child: Text("Proceed",
                            style: AppTypography.textMd.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
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
