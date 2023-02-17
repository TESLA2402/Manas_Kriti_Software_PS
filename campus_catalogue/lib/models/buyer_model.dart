class Buyer {
  final String user_id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String address;

  Buyer(
      {required this.user_id,
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
      'user_id': user_id
    };
  }

  Buyer.fromMap(Map<String, dynamic> buyerMap)
      : name = buyerMap["name"],
        userName = buyerMap["user_name"],
        email = buyerMap["email"],
        phone = buyerMap["phone"],
        address = buyerMap["address"],
        user_id = buyerMap["user_id"];
}