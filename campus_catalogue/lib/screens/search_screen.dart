import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final searchController = TextEditingController();
  List<String> searchTerms = [];
  List itemSearchResult = [];
  List shopSearchResult = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  getSearchResult(searchTerm) async {
    final searchResult = await FirebaseFirestore.instance
        .collection("cache")
        .doc(searchTerm)
        .get();
    return searchResult;
  }

  void searchSubmit() async {
    searchTerms = searchController.text.split(' ');
    Set items = {};
    Set shops = {};
    for (int i = 0; i < searchTerms.length; i++) {
      var tmp = (await getSearchResult(searchTerms[i]));
      itemSearchResult = tmp['items'];
      shopSearchResult = tmp['shops'];

      for (var item in itemSearchResult) {
        items.add(item);
      }
      for (var shop in shopSearchResult) {
        shops.add(shop);
      }

      items.toList();
      shops.toList();

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => SearchScreen(
      //               itemSearchResult: itemSearchResult,
      //               shopSearchResult: shopSearchResult,
      //               isSearch: true,
      //             )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 25, 0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  controller: searchController,
                  onSubmitted: (e) => searchSubmit(),
                  autofocus: false,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.backgroundOrange)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.backgroundOrange)),
                      hintText: 'Search',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: AppColors.secondary,
                        size: 30,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final String name;
  final String rating;
  final String location;
  final bool status;
  final String imgURL;

  const ShopCard(
      {super.key,
      required this.name,
      required this.rating,
      required this.location,
      required this.status,
      required this.imgURL});

  @override
  Widget build(BuildContext context) {
    String _status;
    if (status) {
      _status = "Open";
    } else {
      _status = "Closed";
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      height: 128,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color(0xFFFFF2E0),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.textMd
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.pin_drop, size: 18),
                        Text(location,
                            style: AppTypography.textSm.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.door_back_door_rounded, size: 18),
                        Text(_status,
                            style: AppTypography.textSm.copyWith(
                                fontSize: 10, fontWeight: FontWeight.normal)),
                      ],
                    ),
                    Container(
                        width: 40,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFFFFEF6)),
                        child: Row(
                          children: [
                            Text(
                              rating,
                              style: AppTypography.textSm.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            const Icon(
                              Icons.star,
                              size: 15,
                            )
                          ],
                        ))
                  ],
                ),
                Image.asset("assets/temp.png")
              ],
            ),
          )),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final List items;
  final List shopResults;
  final bool isSearch;
  final String title;
  const SearchScreen(
      {super.key,
      required this.items,
      required this.shopResults,
      required this.isSearch,
      required this.title});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class ShopHeader extends StatelessWidget {
  final String name;
  const ShopHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text(name,
            style: AppTypography.textMd.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.secondary)),
      ),
    );
  }
}

class _SearchScreenState extends State<SearchScreen> {
  // List<Map<String, dynamic>> shops = [];
  // getShopObject(shop) async {
  //   final tmp =
  //       await FirebaseFirestore.instance.collection("shops").doc(shop).get();
  //   return tmp;
  // }

  // void getShops() async {
  //   for (var shop in widget.shopResults) {
  //     var tmp = (await getShopObject(shop));
  //     shops.add(tmp.data());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List openShops = [];
    List closedShops = [];
    for (var shop in widget.shopResults) {
      if (shop["status"]) {
        openShops.add(shop);
      } else {
        closedShops.add(shop);
      }
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.backgroundOrange,
            ),
          ),
          backgroundColor: AppColors.backgroundYellow,
          elevation: 0,
          centerTitle: true,
          title: Text("Explore IITG",
              style: AppTypography.textMd.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.backgroundOrange)),
        ),
        backgroundColor: AppColors.backgroundYellow,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SearchInput(),
              const ShopHeader(name: "Currently open shops"),
              for (var shop in openShops)
                ShopCard(
                  name: shop["name"],
                  rating: shop["rating"],
                  location: shop["location"],
                  imgURL: shop["imgURL"],
                  status: shop["status"],
                ),
              const ShopHeader(name: "Currently closed shops"),
              for (var shop in closedShops)
                ShopCard(
                  name: shop["name"],
                  rating: shop["rating"],
                  location: shop["location"],
                  imgURL: shop["imgURL"],
                  status: shop["status"],
                )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.backgroundOrange,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ));
  }
}
