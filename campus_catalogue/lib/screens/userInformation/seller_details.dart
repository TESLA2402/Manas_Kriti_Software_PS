import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/screens/userInformation/buyer_details.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails({Key? key}) : super(key: key);

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  final List<String> shopTypeitems = [
    'Food and Beverages',
    'Restaurant',
    'Stationary',
  ];
  final List<String> locationItems = [
    'Hostel Canteen',
    'Hostel Juice Centre',
    'Market Complex',
    'Khokha Stalls',
    'Food Court',
    'Swimming Pool Area',
  ];

  @override
  final TextEditingController _shopNameController = TextEditingController();
  String? selectedShopType;
  String? selectedLocation;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 36),
        child: Column(children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 32,
                      color: Color(0xFFFC8019),
                    )),
              ),
              Spacer(),
              Text(
                "1/2",
                style: AppTypography.textMd.copyWith(color: Color(0xFFFC8019)),
              )
            ],
          ),
          const SizedBox(
            height: 84,
          ),
          Text(
            "Create New Seller Account",
            style: AppTypography.textMd
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Please fill up all inputs to create a new seller account.",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldsFormat(
                    text: _shopNameController,
                    title: "Shop Name",
                    maxlines: 1,
                  ),
                  Text(
                    "Shop Type",
                    style: AppTypography.textSm.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 40,
                    child: DropdownButtonFormField2(
                      buttonDecoration: BoxDecoration(
                          color: AppColors.backgroundYellow,
                          borderRadius: BorderRadius.circular(6)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(width: 0)),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        '',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: shopTypeitems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select shop type.';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedShopType = value.toString();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Location",
                    style: AppTypography.textSm.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 40,
                    child: DropdownButtonFormField2(
                      buttonDecoration: BoxDecoration(
                          color: AppColors.backgroundYellow,
                          borderRadius: BorderRadius.circular(6)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        '',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: locationItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Location.';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedLocation = value.toString();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Opening Time",
                            style: AppTypography.textSm.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 40,
                            width: 85,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  suffixIcon: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "AM",
                                        style: AppTypography.textSm
                                            .copyWith(fontSize: 14),
                                      )),
                                  suffixIconConstraints:
                                      BoxConstraints(minHeight: 0, minWidth: 0),
                                  fillColor: AppColors.backgroundYellow,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: AppColors.backgroundYellow)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: AppColors.backgroundYellow))),
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: [
                          Text(
                            "Closing Time",
                            style: AppTypography.textSm.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 40,
                            width: 85,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  suffixIcon: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "PM",
                                        style: AppTypography.textSm
                                            .copyWith(fontSize: 14),
                                      )),
                                  suffixIconConstraints:
                                      BoxConstraints(minHeight: 0, minWidth: 0),
                                  fillColor: AppColors.backgroundYellow,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: AppColors.backgroundYellow)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          width: 0,
                                          color: AppColors.backgroundYellow))),
                              autofocus: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SellerAdditional()),
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
                        child: Text("Proceed",
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

class SellerAdditional extends StatefulWidget {
  const SellerAdditional({Key? key}) : super(key: key);

  @override
  _SellerAdditionalState createState() => _SellerAdditionalState();
}

class _SellerAdditionalState extends State<SellerAdditional> {
  @override
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alternatePhoneController =
      TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFEF6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 36),
        child: Column(children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 32,
                      color: Color(0xFFFC8019),
                    )),
              ),
              Spacer(),
              Text(
                "2/2",
                style: AppTypography.textMd.copyWith(color: Color(0xFFFC8019)),
              )
            ],
          ),
          const SizedBox(
            height: 84,
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
                    text: _ownerNameController,
                    title: "Owner Name",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _phoneController,
                    title: "Phone Number",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _alternatePhoneController,
                    title: "Alternate Phone Number",
                    maxlines: 1,
                  ),
                  FieldsFormat(
                    text: _upiIdController,
                    title: "UPI ID",
                    maxlines: 2,
                  ),
                ],
              )),
          const SizedBox(
            height: 32,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 2, color: Color(0xFFFC8019))),
            child: Text(
              "Add Food Items",
              style: AppTypography.textMd.copyWith(
                  fontWeight: FontWeight.w700, color: Color(0xFFFC8019)),
            ),
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
                        child: Text("Proceed",
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
