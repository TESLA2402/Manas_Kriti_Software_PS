import 'package:campus_catalogue/add_item.dart';
import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:campus_catalogue/screens/seller_home_screen.dart';
import 'package:campus_catalogue/screens/userInformation/buyer_details.dart';
import 'package:campus_catalogue/services/database_service.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class SellerDetails extends StatefulWidget {
  SellerDetails({Key? key}) : super(key: key);

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
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  String selectedShopType = "";
  String selectedLocation = "";
  final _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
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
                        buttonPadding:
                            const EdgeInsets.only(left: 20, right: 10),
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
                        onChanged: (value) {
                          selectedShopType = value.toString();
                        },
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
                        buttonPadding:
                            const EdgeInsets.only(left: 20, right: 10),
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
                        onChanged: (value) {
                          selectedLocation = value.toString();
                        },
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
                              style:
                                  AppTypography.textSm.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 40,
                              width: 85,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter time';
                                  }
                                  return null;
                                },
                                controller: _openingTimeController,
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
                                    suffixIconConstraints: BoxConstraints(
                                        minHeight: 0, minWidth: 0),
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
                                            color:
                                                AppColors.backgroundYellow))),
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
                              style:
                                  AppTypography.textSm.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 40,
                              width: 85,
                              child: TextFormField(
                                controller: _closingTimeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter time}';
                                  }
                                  return null;
                                },
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
                                    suffixIconConstraints: BoxConstraints(
                                        minHeight: 0, minWidth: 0),
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
                                            color:
                                                AppColors.backgroundYellow))),
                                autofocus: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SellerAdditional(
                        shopName: _shopNameController.text,
                        closingTime: _closingTimeController.text,
                        location: selectedLocation,
                        openingTime: _openingTimeController.text,
                        shopType: selectedShopType)),
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
  String shopName;
  String shopType;
  String location;
  String openingTime;
  String closingTime;
  SellerAdditional(
      {Key? key,
      required this.shopName,
      required this.closingTime,
      required this.location,
      required this.openingTime,
      required this.shopType})
      : super(key: key);

  @override
  _SellerAdditionalState createState() => _SellerAdditionalState();
}

class _SellerAdditionalState extends State<SellerAdditional> {
  List<dynamic> menu = [];
  @override
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alternatePhoneController =
      TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
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
                      maxlines: 1,
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () => {
              // print('hello')
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditMenu(
                          menu: menu,
                        )),
              )
            },
            child: Container(
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
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                DatabaseService service = DatabaseService();
                final FirebaseAuth _auth = FirebaseAuth.instance;
                final User user = await _auth.currentUser!;
                ShopModel shop = ShopModel(
                    shopID: user.uid,
                    alternatePhoneNumber: _alternatePhoneController.text,
                    closingTime: widget.closingTime,
                    location: widget.location,
                    openingTime: widget.openingTime,
                    ownerName: _ownerNameController.text,
                    phoneNumber: _phoneController.text,
                    shopName: widget.shopName,
                    shopType: widget.shopType,
                    upiId: _upiIdController.text,
                    menu: menu,
                    status: true,
                    rating: {"rating": 0, "num_ratings": 2});

                await service.addShop(shop);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellerHomeScreen(
                            shop: shop,
                          )),
                );
              }
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
