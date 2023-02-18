class OrderModel {
  String name;
  String buyerName;
  String price;

  OrderModel({
    required this.name,
    required this.price,
    required this.buyerName,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'buyer_name': buyerName};
  }

  OrderModel.fromMap(Map<String, dynamic> sellerMap)
      : name = sellerMap["name"],
        price = sellerMap["price"],
        buyerName = sellerMap["buyer_name"];
}
