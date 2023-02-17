import 'package:campus_catalogue/models/buyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addEmployee(Buyer employeeData) async {
    await _db.collection("Buyer").add(employeeData.toMap());
  }
}
