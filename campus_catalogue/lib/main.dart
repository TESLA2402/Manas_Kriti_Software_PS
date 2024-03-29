import 'package:campus_catalogue/add_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campus_catalogue/screens/splash_screen.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'campus_catalogue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
