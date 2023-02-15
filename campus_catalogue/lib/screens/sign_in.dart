import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/screens/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static String verify = "";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();
  Widget build(BuildContext context) {
    var phone;
    _countryCode.text = "+91";
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 144, 20, 0),
        child: Column(children: [
          Text(
            "Sign In",
            style: AppTypography.textMd
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Please fill up phone number to log in to your \naccount.",
            textAlign: TextAlign.center,
            style: AppTypography.textSm.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFFEC490)),
                color: AppColors.signIn),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Phone Number",
                style: AppTypography.textSm.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: InputDecoration(
                      fillColor: AppColors.backgroundYellow,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0, color: AppColors.backgroundYellow))),
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController)
            ]),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: _countryCode.text + phone,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  SignIn.verify = verificationId;
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerifyOtp()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF57C51),
                      ),
                      child: Center(
                        child: Text("Sign In",
                            style: AppTypography.textMd.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
