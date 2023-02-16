import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/screens/sign_in.dart';
import 'package:flutter/material.dart';

class BuyerDetails extends StatefulWidget {
  const BuyerDetails({Key? key}) : super(key: key);

  @override
  _BuyerDetailsState createState() => _BuyerDetailsState();
}

class _BuyerDetailsState extends State<BuyerDetails> {
  @override
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 140, 20, 36),
        child: Column(children: [
          Text(
            "Create New Buyer Account",
            style: AppTypography.textMd
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Please fill up all inputs to create a new buyer account.",
            textAlign: TextAlign.center,
            style: AppTypography.textSm.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0, color: Color(0xFFFEC490)),
                  color: AppColors.signIn),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  FieldsFormat(
                    text: _nameController,
                    title: "Name*",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _userNameController,
                    title: "Username*",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _emailController,
                    title: "E-mail* (preferably outlook id)",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _phoneController,
                    title: "Phone Number*",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _addressController,
                    title: "Add Address*",
                    maxlines: 2,
                  ),
                ],
              )),
          const Spacer(),
          GestureDetector(
            onTap: () async {},
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
                        child: Text("Continue",
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

class FieldsFormat extends StatefulWidget {
  String title;
  TextEditingController text;
  int maxlines;
  FieldsFormat(
      {Key? key,
      required this.title,
      required this.text,
      required this.maxlines})
      : super(key: key);

  @override
  _FieldsFormatState createState() => _FieldsFormatState();
}

class _FieldsFormatState extends State<FieldsFormat> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.title,
        style: AppTypography.textSm.copyWith(fontSize: 14),
      ),
      const SizedBox(
        height: 4,
      ),
      SizedBox(
        height: widget.title == "Add Address*" ? 76 : 40,
        child: TextField(
            enabled: widget.title == "Phone Number*" ? false : true,
            textAlign: TextAlign.start,
            maxLines: widget.maxlines,
            decoration: InputDecoration(
                fillColor: AppColors.backgroundYellow,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        width: 0, color: AppColors.backgroundYellow)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        width: 0, color: AppColors.backgroundYellow))),
            autofocus: true,
            controller: widget.title == "Phone Number*"
                ? (widget.text..text = SignIn.phoneNumber)
                : widget.text),
      ),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}
