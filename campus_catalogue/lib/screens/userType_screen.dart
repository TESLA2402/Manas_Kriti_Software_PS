import 'package:campus_catalogue/constants/typography.dart';
import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 144, 20, 36),
        child: Column(children: [
          Text(
            "Welcome Onboard!",
            style: AppTypography.textMd
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Select your user type.",
            textAlign: TextAlign.center,
            style: AppTypography.textSm.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 38,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 21, 10, 29),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2E0),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFFC8019)),
            ),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Buyer",
                    style: AppTypography.textMd
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Join as a buyer, if you \nwant to purchase any \nitem or avail any \nservice",
                    style: AppTypography.textSm.copyWith(fontSize: 14),
                  )
                ],
              ),
              const Spacer(),
              Image.asset(
                "assets/images/buyer_type.png",
                height: 130,
                width: 130,
              )
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 21, 10, 29),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2E0),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFFC8019)),
            ),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Seller",
                    style: AppTypography.textMd
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Join as a seller, if you \nwant to sell any item \nor provide any \nservice.",
                    style: AppTypography.textSm.copyWith(fontSize: 14),
                  )
                ],
              ),
              Spacer(),
              Image.asset(
                "assets/images/seller_type.png",
                height: 130,
                width: 130,
              )
            ]),
          ),
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
