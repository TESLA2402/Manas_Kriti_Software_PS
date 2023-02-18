import 'dart:io';

import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:campus_catalogue/models/shopModel.dart';

class ShopPage extends StatefulWidget {
  ShopPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    ShopModel shop;
    const color = const Color(0xFC8019);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 53.77, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Text(
              'Manas Canteen',
              style: TextStyle(
                color: AppColors.backgroundOrange,
                letterSpacing: 2.0,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 40.77, 0.0, 0.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                        ),
                        Text(' 15 MINS FAR'),
                      ]),
                      SizedBox(height: 4.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.sensor_door_outlined,
                        ),
                        Text(' 9AM to 3AM'),
                      ]),
                      SizedBox(height: 4.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.animation_outlined,
                        ),
                        Text(' 32 ITEMS IN STOCK'),
                      ]),
                      SizedBox(height: 8.0),
                      Row(children: <Widget>[
                        Text('      RATE   '),
                        Icon(
                          Icons.star_half_outlined,
                        ),
                        Text('4.1')
                      ]),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                        image: NetworkImage(
                            'https://www.tutorialkart.com/img/hummingbird.png'),
                        height: 150),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                OutlinedButton(
                  child: Text('Directions',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      )),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.backgroundOrange,
                  ),
                ),
                SizedBox(width: 7.0),
                OutlinedButton(
                  child: Text('  Call  ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.backgroundOrange,
                      )),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 7.0),
                OutlinedButton(
                  child: Text('  Share  ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.backgroundOrange,
                      )),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
