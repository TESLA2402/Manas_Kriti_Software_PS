import 'package:campus_catalogue/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Buyer {
  final String user_id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String address;
  CartModel? cart;

  Buyer(
      {this.cart,
      required this.user_id,
      required this.name,
      required this.userName,
      required this.email,
      required this.phone,
      required this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user_name': userName,
      'email': email,
      'phone': phone,
      'address': address,
      'user_id': user_id,
      'cart_items': cart
    };
  }

  Buyer.fromMap(Map<String, dynamic> buyerMap)
      : name = buyerMap["name"],
        userName = buyerMap["user_name"],
        email = buyerMap["email"],
        phone = buyerMap["phone"],
        address = buyerMap["address"],
        user_id = buyerMap["user_id"],
        cart = buyerMap["cart_items"];

  Buyer.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : user_id = doc.data()!["user_id"],
        name = doc.data()!["name"],
        userName = doc.data()!['user_name'],
        email = doc.data()!['email'],
        phone = doc.data()!['phone'],
        address = doc.data()!['address'],
        cart = doc.data()!['cart_items'];
}
