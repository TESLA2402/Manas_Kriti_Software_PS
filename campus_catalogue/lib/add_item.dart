import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

List<String> all_categories = [];

void fetch_categories() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var x = await db.collection('categories').get();
  for (int i = 0; i < x.size; i++) {
    all_categories.add(x.docs[i].id);
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final Function delete_card;
  const CategoryCard(
      {super.key, required this.category, required this.delete_card});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Text(category),
        GestureDetector(
          child: Icon(Icons.disabled_by_default),
          onTap: () {
            delete_card(category);
          },
        )
      ],
      mainAxisSize: MainAxisSize.min,
    ));
  }
}

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool non_vegetarian = false;
  XFile? sampleImage;

  Set<String> selected_categories = {};
// Set<String> unselected_categories = {};
  Set<String> unselected_categories = all_categories.toSet();

  void delete_card(String category) {
    selected_categories.remove(category);
    unselected_categories.add(category);
    setState(() {});
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget x;
    if (sampleImage == null) {
      x = Image.network(
          'https://firebasestorage.googleapis.com/v0/b/manas-kriti-appd.appspot.com/o/cloud-upload-a30f385a928e44e199a62210d578375a.jpg?alt=media&token=dbc10511-b70c-41ad-9db6-435c8247e0c0',
          height: 100
          // height: 400,
          );
    } else {
      x = Image.file(
        File(sampleImage!.path),
        height: 100,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add food items sold'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            x,
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
            Text('Tags'),
            Text(
                'Tags help us show your menu items to relevant customers(improve this wording)'),
            Wrap(
                // runAlignment: ,
                children: selected_categories.toList().map((category) {
              return CategoryCard(category: category, delete_card: delete_card);
            }).toList()),
            DropdownButton<String>(
              hint: Text((unselected_categories.isEmpty)
                  ? 'All chosen'
                  : 'Add category'),
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              onChanged: (String? value) {
                selected_categories.add(value!);
                unselected_categories.remove(value);
                refresh();
              },
              items: unselected_categories
                  .toList()
                  .map<DropdownMenuItem<String>>((String value) {
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
      ),
    );
  }
}

