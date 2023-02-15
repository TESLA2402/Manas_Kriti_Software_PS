import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:campus_catalogue/add_item.dart';

Future<void> add_to_database(collection, data, {id = 0}) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    if (id == 0) {
      await db.collection(collection).add(data);
    } else {
      await db.collection(collection).doc(id).set(data);
    }
  } catch (err) {
    throw Exception(err);
  }
}


class AddShop extends StatefulWidget {
  const AddShop({super.key});

  @override
  State<AddShop> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Shop'),
      ),
      body: Column(
        children: [
          // to add: id,name,owner name,phone,payment id,menu,open time,close time,location,images
          // TextFormField(_)
          ElevatedButton(
              child: const Text('Add Menu'),
              onPressed: () => {Navigator.pushNamed(context, '/additem')}),
          ElevatedButton(
              child: const Text("Done"),
              onPressed: () => add_to_database('shops', {'name': 'hello'})),
        ],
      ),
    );
  }
}
