import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class ShopHeader extends StatelessWidget {
  final String name;
  const ShopHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
        child: Text(name,
            style: AppTypography.textMd.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary)),
      ),
    );
  }
}

class ShopCardWrapper extends StatelessWidget {
  final List shops; // Map {name, imgURL, rating, location}
  const ShopCardWrapper({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          itemCount: shops.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: ShopCard(
                  name: shops[index]["name"],
                  imgURL: shops[index]["imgURL"],
                  rating: shops[index]["rating"],
                  location: shops[index]["location"]),
            );
          }),
    );
  }
}

class ShopCard extends StatelessWidget {
  final String name;
  final String imgURL;
  final String rating;
  final String location;
  const ShopCard(
      {super.key,
      required this.name,
      required this.imgURL,
      required this.rating,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color(0xFFFFF2E0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imgURL),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: AppTypography.textMd
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(location,
                        style: AppTypography.textSm.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w400))
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0xFFFFFEF6)),
                    child: Row(
                      children: [
                        Text(
                          rating,
                          style: AppTypography.textSm.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                        const Icon(
                          Icons.star,
                          size: 10,
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class LocationCardWrapper extends StatelessWidget {
  const LocationCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 35, 10, 0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("What are you looking for?",
                    style: AppTypography.textMd.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary)),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Wrap(spacing: 8.8, runSpacing: 6.5, children: const [
                  LocationCard(
                      name: "Hostel Canteens",
                      imgURL: "assets/hostel_canteens.png"),
                  LocationCard(
                      name: "Hostel Juice Centres",
                      imgURL: "assets/core_canteens.png"),
                  LocationCard(
                      name: "Market Complex",
                      imgURL: "assets/market_complex.png"),
                  LocationCard(
                      name: "Khokha Market",
                      imgURL: "assets/khokha_stalls.png"),
                  LocationCard(
                      name: "Food Court", imgURL: "assets/food_court.png"),
                  LocationCard(
                      name: "Swimming Pool Area",
                      imgURL: "assets/food_van.png"),
                ]),
              ),
            ],
          ),
        ));
  }
}

class LocationCard extends StatelessWidget {
  final String name;
  final String imgURL;
  const LocationCard({super.key, required this.name, required this.imgURL});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: MediaQuery.of(context).size.width * 0.285,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color(0xFFFFF2E0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imgURL),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    name,
                    style: AppTypography.textMd.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.backgroundYellow,
            elevation: 0,
            title: Text("Explore IITG",
                style: AppTypography.textMd.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.backgroundOrange)),
            actions: [
              IconButton(onPressed: () {}, icon: Image.asset("assets/user.png"))
            ]),
        backgroundColor: AppColors.backgroundYellow,
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SearchInput(),
              LocationCardWrapper(),
              ShopHeader(name: "Campus Favourites"),
              ShopCardWrapper(shops: [
                {
                  "name": "Roasted Pot",
                  "imgURL": "assets/temp.png",
                  "rating": "4.7",
                  "location": "Khokha Market"
                },
                {
                  "name": "Lauriat",
                  "imgURL": "assets/temp.png",
                  "rating": "2.6",
                  "location": "Market Complex"
                },
                {
                  "name": "Taco Tales",
                  "imgURL": "assets/temp.png",
                  "rating": "3.4",
                  "location": "Swimming Pool Area"
                }
              ]),
              ShopHeader(name: "Recommended"),
              ShopCardWrapper(shops: [
                {
                  "name": "Roasted Pot",
                  "imgURL": "assets/temp.png",
                  "rating": "4.7",
                  "location": "Khokha Market"
                },
                {
                  "name": "Lauriat",
                  "imgURL": "assets/temp.png",
                  "rating": "2.6",
                  "location": "Market Complex"
                },
                {
                  "name": "Taco Tales",
                  "imgURL": "assets/temp.png",
                  "rating": "3.4",
                  "location": "Swimming Pool Area"
                }
              ]),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
