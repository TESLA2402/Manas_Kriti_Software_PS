class ShopModel {
  String shopID;
  String upiId;
  String shopName;
  String shopType;
  String location;
  String openingTime;
  String closingTime;
  String ownerName;
  String phoneNumber;
  String alternatePhoneNumber;

  ShopModel(
      {required this.shopID,
      required this.alternatePhoneNumber,
      required this.closingTime,
      required this.location,
      required this.openingTime,
      required this.ownerName,
      required this.phoneNumber,
      required this.shopName,
      required this.shopType,
      required this.upiId});

  Map<String, dynamic> toMap() {
    return {
      'shop_id': shopID,
      'upi_id': upiId,
      'shop_name': shopName,
      'shop_type': shopType,
      'location': location,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'owner_name': ownerName,
      'phone_number': phoneNumber,
      'alternate_phone_number': alternatePhoneNumber
    };
  }

  ShopModel.fromMap(Map<String, dynamic> sellerMap)
      : shopID = sellerMap["shop_id"],
        shopName = sellerMap["shop_name"],
        upiId = sellerMap["upi_id"],
        shopType = sellerMap["shop_type"],
        location = sellerMap["location"],
        openingTime = sellerMap["opening_time"],
        closingTime = sellerMap["closing_time"],
        ownerName = sellerMap["owner_name"],
        phoneNumber = sellerMap["phone_number"],
        alternatePhoneNumber = sellerMap["alternate_phone_number"];
}
