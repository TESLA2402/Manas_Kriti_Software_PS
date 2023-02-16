import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
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
                child: Wrap(spacing: 8.8, runSpacing: 6.5, children: [
                  const LocationCard(
                      name: "Hostel Canteens",
                      imgURL: "assets/hostel_canteens.png"),
                  const LocationCard(
                      name: "Core Canteens",
                      imgURL: "assets/core_canteens.png"),
                  const LocationCard(
                      name: "Market Complex",
                      imgURL: "assets/market_complex.png"),
                  const LocationCard(
                      name: "Khokha Market",
                      imgURL: "assets/khokha_stalls.png"),
                  const LocationCard(
                      name: "Food Court", imgURL: "assets/food_court.png"),
                  const LocationCard(
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
              children: [
                Image.asset(imgURL),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 25, 0),
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
                      suffixIcon: Icon(
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
        body: Column(
          children: [SearchInput(), const LocationCardWrapper()],
        ));
  }
}
