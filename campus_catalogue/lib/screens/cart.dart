import 'package:campus_catalogue/models/shopModel.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  ShopModel shop;
  Cart({Key? key, required this.shop}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
