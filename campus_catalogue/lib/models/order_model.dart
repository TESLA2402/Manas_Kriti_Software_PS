import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String buyerPhone;
  String buyerName;
  String txnId;
  String status;
  int totalAmount;
  List items;

  OrderModel(
      {required this.buyerPhone,
      required this.buyerName,
      required this.txnId,
      required this.status,
      required this.totalAmount,
      required this.items});

  Map<String, dynamic> toMap() {
    return {
      'buyer_phone': buyerPhone,
      'buyer_name': buyerName,
      'txn_id': txnId,
      'status': status,
      'total_amount': totalAmount,
      'items': items
    };
  }

  OrderModel.fromMap(Map<String, dynamic> sellerMap)
      : buyerPhone = sellerMap["buyer_phone"],
        buyerName = sellerMap["buyer_name"],
        txnId = sellerMap["txn_id"],
        status = sellerMap["status"],
        totalAmount = sellerMap["total_amount"],
        items = sellerMap["items"];

  OrderModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : buyerPhone = doc.data()!["buyer_phone"],
        buyerName = doc.data()!["buyerName"],
        txnId = doc.data()!['txn_id'],
        status = doc.data()!['status'],
        totalAmount = doc.data()!['total_amount'],
        items = doc.data()!["items"];
}
