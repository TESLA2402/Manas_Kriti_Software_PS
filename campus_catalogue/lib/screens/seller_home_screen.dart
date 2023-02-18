import 'package:campus_catalogue/add_item.dart';
import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:campus_catalogue/models/order_model.dart';
import 'package:campus_catalogue/models/shopModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_catalogue/services/database_service.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatefulWidget {
  ShopModel shop;
  SellerHomeScreen({Key? key, required this.shop}) : super(key: key);

  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  List<dynamic> menu = [];
  DatabaseService service = DatabaseService();
  Future<List<OrderModel>>? orders;

  @override
  void initState() {
    super.initState();
    initRetrieval();
  }

  Future<void> initRetrieval() async {
    orders = service.retrieveOrders(widget.shop.shopID);
  }

  @override
  Widget build(BuildContext context) {
    for (var item in widget.shop.menu) {
      Map<String, dynamic> tmp = {
        "name": item["name"],
        "price": item["price"],
        "vegetarian": item["vegetarian"],
        "description": item["description"],
        "category": item["category"],
      };

      menu.add(tmp);
    }

    int _selectedIndex = 0;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.black),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                "Explore IITG",
                style: AppTypography.textMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.backgroundOrange),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.backgroundYellow,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 2, color: AppColors.backgroundOrange)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Today’s income",
                        style: AppTypography.textMd.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Rs. 0.00",
                        style: AppTypography.textMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.backgroundOrange),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Upi ID",
                        style: AppTypography.textMd.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.shop.upiId,
                        style: AppTypography.textMd.copyWith(fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Shop Management",
              style: AppTypography.textMd
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditMenu(menu: menu))),
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 35),
                  decoration: BoxDecoration(
                      color: AppColors.signIn,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Update Menu",
                      style: AppTypography.textMd
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Current Orders",
              style: AppTypography.textMd.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: orders?.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Column(
                    children: [
                      OrderTile(
                        order: order,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  OrderModel order;
  OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.signIn,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_circle_rounded,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.order.buyerPhone,
                    style: AppTypography.textMd
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  //const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Text(
                    widget.order.buyerName,
                    style: AppTypography.textMd
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundOrange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "CONFIRM",
                      style: AppTypography.textMd.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundYellow,
                        border: Border.all(
                            width: 1, color: AppColors.backgroundOrange),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "REJECT",
                      style: AppTypography.textMd.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundYellow,
                        border: Border.all(
                            width: 1, color: AppColors.backgroundOrange),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "VIEW",
                      style: AppTypography.textMd.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  //Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Rs." + widget.order.totalAmount.toString(),
                      textAlign: TextAlign.end,
                      style: AppTypography.textMd
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 10),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
