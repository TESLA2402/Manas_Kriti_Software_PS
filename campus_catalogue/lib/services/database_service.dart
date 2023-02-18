import 'package:campus_catalogue/models/buyer_model.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addBuyer(Buyer employeeData) async {
    await _db.collection("Buyer").add(employeeData.toMap());
  }

  addShop(ShopModel employeeData) async {
    // List menu = employeeData.menu;
    // employeeData.menu = [];
    // for (int i = 0; i < menu.length; i++) {
    //   menu[i].remove('unselected_categories');
    //   if (menu[i].containsKey('id')) {
    //     String id = menu[i]['id'];
    //     employeeData.menu.add(id);
    //     menu[i].remove('id');
    //     await _db.collection('items').doc(id).set(menu[i]);
    //   } else {
    //     DocumentReference docref = await _db.collection('items').add(menu[i]);
    //     employeeData.menu.add(docref.id);
    //   }
    // }
    // String s = '';
    Set s = {};

    for (int i = 0; i < employeeData.menu.length; i++) {
      // s = s+ employeeData.menu['name'];
      s.addAll(employeeData.menu[i]['name'].toString().split(' '));
    }
    s.addAll(employeeData.location.toString().split(' '));
    s.addAll(employeeData.shopName.toString().split(' '));

    DocumentReference docref =
        await _db.collection("shops").add(employeeData.toMap());

    List a = s.toList();
    for (int i = 0; i < a.length; i++) {
      var p =await _db.collection('cache').doc(a[i]).get();
      if(p.exists) {
        _db.collection('cache').doc(a[i]).update({'list': docref.id});
      } else {
        _db.collection('cache').add({a[i]:[docref.id]});
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
}
