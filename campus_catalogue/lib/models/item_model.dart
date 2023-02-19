import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String name;
  String price;
  String category;
  bool vegetarian;
  String description;

  ItemModel(
      {required this.category,
      required this.description,
      required this.name,
      required this.price,
      required this.vegetarian});

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'name': name,
      'price': price,
      'vegetarian': vegetarian
    };
  }

  ItemModel.fromMap(Map<String, dynamic> sellerMap)
      : category = sellerMap["category"],
        description = sellerMap["description"],
        name = sellerMap["name"],
        price = sellerMap["price"],
        vegetarian = sellerMap["vegetarian"];

  ItemModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        description = doc.data()!["description"],
        category = doc.data()!["category"],
        price = doc.data()!["price"],
        vegetarian = doc.data()!["vegetarian"];
}
