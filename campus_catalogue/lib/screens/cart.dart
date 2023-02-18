import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/models/item_model.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

class Cart extends StatefulWidget {
  Cart({
    Key? key,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 36),
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 32,
                        color: Color(0xFFFC8019),
                      )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Cart",
                    textAlign: TextAlign.center,
                    style:
                        AppTypography.textMd.copyWith(color: Color(0xFFFC8019)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            ItemCard(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 2, color: Colors.black)),
              child: Column(
                children: [
                  Row(
                    children: [Text("Grand total"), Spacer(), Text("Rs 200")],
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {},
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF57C51),
                        ),
                        child: Center(
                          child: Text("Pay",
                              style: AppTypography.textMd.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    ItemModel item = ItemModel(
        shopID: "shopID",
        category: "category",
        description: "description",
        name: "name",
        price: "price",
        vegetarian: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.signIn, borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.asset(
                "assets/images/veg_icon.png",
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppTypography.textSm
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "PRICE:" + item.price,
                    style: AppTypography.textSm.copyWith(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              Spacer(),
              QuantityInput(
                  value: quantity,
                  elevation: 0,
                  iconColor: Colors.black,
                  buttonColor: AppColors.signIn,
                  onChanged: (value) => setState(
                      () => quantity = int.parse(value.replaceAll(',', '')))),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
