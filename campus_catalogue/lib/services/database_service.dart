import 'package:campus_catalogue/models/buyer_model.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addBuyer(Buyer employeeData) async {
    await _db.collection("Buyer").add(employeeData.toMap());
  }

  addShop(ShopModel employeeData) async {
    await _db.collection("shop").add(employeeData.toMap());
  }

  Future<List> retrieveBuyer() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Buyer").get();
    return snapshot.docs
        .map((docSnapshot) => Buyer.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
