import 'dart:collection';

import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/models/item_model.dart';
import 'package:campus_catalogue/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final bool vegetarian;
  const ItemCard(
      {super.key,
      required this.name,
      required this.price,
      required this.description,
      required this.vegetarian});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color(0xFFFFF2E0),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (vegetarian)
                      Text(
                        "VEG",
                        style: AppTypography.textSm.copyWith(
                            color: Color.fromARGB(255, 0, 196, 0),
                            fontSize: 14),
                      )
                    else
                      Text("NON VEG",
                          style: AppTypography.textSm.copyWith(
                              color: Color.fromARGB(255, 197, 0, 0),
                              fontSize: 14)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text("PRICE: Rs. ${price}",
                          style: AppTypography.textSm.copyWith(fontSize: 14)),
                    ),
                    Text(
                      name,
                      style: AppTypography.textMd
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      description,
                      style: AppTypography.textSm
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    DatabaseService service = DatabaseService();
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final User user = await _auth.currentUser!;
                    ItemModel item = ItemModel(
                        category: "xbks",
                        description: "hey",
                        name: name,
                        price: price.toString(),
                        vegetarian: vegetarian);
                    await service.addToCart(item);
                  },
                  child: Text("ADD TO CART"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundOrange),
                )
              ],
            ),
          )),
    );
    ;
  }
}

class ShopPage extends StatefulWidget {
  final ShopModel? shop;
  final String name;
  final String rating;
  final String location;
  final List menu;
  final String ownerName;
  final String upiID;
  const ShopPage({
    super.key,
    this.shop,
    required this.name,
    required this.rating,
    required this.location,
    required this.menu,
    required this.ownerName,
    required this.upiID,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.menu);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundYellow,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.backgroundOrange,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(widget.name,
            style: AppTypography.textMd.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.backgroundOrange)),
      ),
      backgroundColor: AppColors.backgroundYellow,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_rounded,
                            size: 15,
                          ),
                          Text(widget.location,
                              style: AppTypography.textMd.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timelapse_rounded, size: 15),
                          Text("9 AM TO 10 PM",
                              style: AppTypography.textMd.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, size: 15),
                          Text("${widget.menu.length} ITEMS AVAILABLE",
                              style: AppTypography.textMd.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Container(
                          width: 30,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.signIn),
                          child: Row(
                            children: [
                              Text(
                                "0",
                                style: AppTypography.textSm.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              const Icon(
                                Icons.star,
                                size: 15,
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "All Items",
                style: AppTypography.textMd
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            for (var item in widget.menu)
              ItemCard(
                  name: item["name"],
                  price: item["price"],
                  description: item["description"],
                  vegetarian: item["veg"]),
          ],
        ),
      ),
    );
  }
}
