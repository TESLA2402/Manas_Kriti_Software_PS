import 'package:campus_catalogue/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final List<ItemModel> items;

  CartModel({required this.items});

  Map<String, dynamic> toMap() {
    return {
      'cart_items': items,
    };
  }

  CartModel.fromMap(Map<String, dynamic> buyerMap)
      : items = buyerMap["cart_items"];

  CartModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : items = doc.data()!["cart_items"];
}
