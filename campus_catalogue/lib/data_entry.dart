import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

Set<String> selected_categories = {};

class CategoryCard extends StatelessWidget {
  final String category;
  final Function refresh;
  const CategoryCard(
      {super.key, required this.category, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: [
      Text(category),

      GestureDetector(child: Icon(Icons.disabled_by_default),
      onTap: (){
        selected_categories.remove(category);
          refresh();
          print(selected_categories);
      },
      )

    ]));
  }
}

fetch_categories() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var x = await db.collection('categories').get();
  List<String> categories = [];
  for (int i = 0; i < x.size; i++) {
    categories.add(x.docs[i].id);
  }
  return categories;
}

class _AddItemState extends State<AddItem> {
  bool non_vegetarian = false;
  var food_cat = ['pizza', 'burger', 'south_indian', 'north_indian'];
  // List<String> selected_categories = [];
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // food_cat = fetch_categories();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add food items sold'),
      ),
      body: Column(
        children: [
          // ElevatedButton(onPressed: () => {}, child: const Text('hi')),
          SizedBox(
            child: TextFormField(
                decoration: const InputDecoration(
              icon: Icon(Icons.local_pizza),
              labelText: 'Item Name',
            )),
          ),
          SizedBox(
            child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'Price',
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.local_pizza),
              const SizedBox(
                width: 16,
              ),
              const Text('Non Vegetarian'),
              Checkbox(
                value: non_vegetarian,
                onChanged: (bool? val) {
                  setState(() {
                    non_vegetarian = true;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            child: TextFormField(
                maxLines: 2,
                decoration: const InputDecoration(
                  icon: Icon(Icons.notes),
                  labelText: 'Description',
                )),
          ),
          Row(
              children: selected_categories.toList().map((cat) {
            return CategoryCard(category: cat, refresh: refresh);
          }).toList()),

          DropdownButton<String>(
            value: food_cat[0],
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            onChanged: (String? value) {
              setState(() {
                selected_categories.add(value!);
              });
            },
            items: food_cat.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          ElevatedButton(
            child: const Text('Done'),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}

class AddShop extends StatefulWidget {
  const AddShop({super.key});

  @override
  State<AddShop> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Shop'),
      ),
      body: Column(
        children: [
          // to add: id,name,owner name,phone,payment id,menu,open time,close time,location,images
          // TextFormField(_)
          ElevatedButton(
              child: const Text('Add Menu'),
              onPressed: () => {Navigator.pushNamed(context, '/additem')}),
          ElevatedButton(
              child: const Text("Done"),
              onPressed: () => add_to_database('shops', {'name': 'hello'})),
        ],
      ),
    );
  }
}

Future<void> add_to_database(collection, data, {id = 0}) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    if (id == 0) {
      await db.collection(collection).add(data);
    } else {
      await db.collection(collection).doc(id).set(data);
    }
  } catch (err) {
    throw Exception(err);
  }
}
