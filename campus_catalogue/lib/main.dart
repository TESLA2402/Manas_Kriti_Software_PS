import 'package:campus_catalogue/add_item.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:campus_catalogue/screens/search_screen.dart';
import 'package:campus_catalogue/screens/onboarding_screen.dart';
import 'package:campus_catalogue/screens/shop_info.dart';
import 'package:campus_catalogue/screens/userInformation/buyer_details.dart';
import 'package:campus_catalogue/screens/userInformation/seller_details.dart';
import 'package:campus_catalogue/screens/userType_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campus_catalogue/screens/splash_screen.dart';
import 'package:campus_catalogue/screens/home_screen.dart';
import 'package:campus_catalogue/screens/search_screen.dart';
import 'package:campus_catalogue/screens/shop_info.dart';
import 'package:campus_catalogue/screens/seller_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51MZHMhSF3jyzuIge766JvDB1tCbBuUk5F1NjHLW66gy4aPeZZxWe6q3CVTmOO1m50N5sEdSfrj7Vrcr5O2EZs4tA00QvS9CKQ6";

  await dotenv.load(fileName: "assets/.env");
  fetch_categories();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ShopModel shop = ShopModel(
        shopID: "QYXb7w0qYkffc6OLTpWCwABPw123",
        alternatePhoneNumber: "1234567891",
        closingTime: "9",
        location: "Khokha Stalls",
        openingTime: "9",
        ownerName: "Bittu Pandey",
        phoneNumber: "8826031449",
        shopName: "Adrika Eats",
        shopType: "Restaurant",
        upiId: "bittu@upi",
        menu: [
          {
            "name": "Pizza",
            "price": 125,
            "vegetarian": true,
            "description": "Exotic cheesy multi level pizza"
          },
          {
            "name": "Pizza",
            "price": 125,
            "vegetarian": false,
            "description": "Exotic cheesy multi level pizza"
          },
          {
            "name": "Pizza",
            "price": 125,
            "vegetarian": true,
            "description": "Exotic cheesy multi level pizza"
          },
          {
            "name": "Pizza",
            "price": 125,
            "vegetarian": true,
            "description": "Exotic cheesy multi level pizza"
          }
        ],
        rating: {
          "rating": 0,
          "num_ratings": 2
        });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ShopPage(shop: shop),

    );
  }
}
