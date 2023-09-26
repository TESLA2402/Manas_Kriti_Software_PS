import 'package:campus_catalogue/models/buyer_model.dart';
import 'package:campus_catalogue/models/item_model.dart';
import 'package:campus_catalogue/models/order_model.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addBuyer(Buyer employeeData) async {
    await _db.collection("Buyer").add(employeeData.toMap());
  }

  addToCart(ItemModel employeeData) async {
    _db
        .collection("Buyer")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("cart_items")
        .add(employeeData.toMap());
    await _db.collection("cart_items").add(employeeData.toMap());
  }

  addShop(ShopModel employeeData) async {
    Set s = {};

    for (int i = 0; i < employeeData.menu.length; i++) {
      // s = s+ employeeData.menu['name'];
      s.addAll(employeeData.menu[i]['name'].toString().split(' '));
    }
    s.addAll(employeeData.location.toString().split(' '));
    s.addAll(employeeData.shopName.toString().split(' '));

    DocumentReference docref =
        await _db.collection("shop").add(employeeData.toMap());

    List a = s.toList();
    for (int i = 0; i < a.length; i++) {
      var p = await _db.collection('cache').doc(a[i]).get();
      if (p.exists) {
        _db.collection('cache').doc(a[i]).set({
          'list': FieldValue.arrayUnion([docref.id])
        });
      } else {
        _db.collection('cache').add({
          a[i]: [docref.id]
        });
      }
    }

    print(employeeData);
  }

  Future<List> retrieveBuyer() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Buyer").get();
    return snapshot.docs
        .map((docSnapshot) => Buyer.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<ItemModel>> retrieveCart() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Buyer")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("cart_items")
        .get();
    return snapshot.docs
        .map((docSnapshot) => ItemModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<OrderModel>> retrieveOrders(shopId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("orders")
        .where("shop_id", isEqualTo: shopId)
        .get();
    return snapshot.docs
        .map((docSnapshot) => OrderModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
