class ItemModel {
  String shopID;
  String name;
  String price;
  String category;
  bool vegetarian;
  String description;

  ItemModel(
      {required this.shopID,
      required this.category,
      required this.description,
      required this.name,
      required this.price,
      required this.vegetarian});

  Map<String, dynamic> toMap() {
    return {
      'shop_id': shopID,
      'category': category,
      'description': description,
      'name': name,
      'price': price,
      'vegetarian': vegetarian
    };
  }

  ItemModel.fromMap(Map<String, dynamic> sellerMap)
      : shopID = sellerMap["shop_id"],
        category = sellerMap["category"],
        description = sellerMap["description"],
        name = sellerMap["name"],
        price = sellerMap["price"],
        vegetarian = sellerMap["vegetarian"];
}
