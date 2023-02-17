import 'dart:io';

import 'package:campus_catalogue/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

List<String> all_categories = [];
check_null(s) {
  if (s == Null) {
    return '';
  } else {
    return s;
  }
}

void fetch_categories() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var x = await db.collection('categories').get();
  for (int i = 0; i < x.size; i++) {
    all_categories.add(x.docs[i].id);
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final Function shift_card;
  final bool is_selected;
  const CategoryCard(
      {super.key,
      required this.category,
      required this.shift_card,
      required this.is_selected});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: is_selected ? Colors.green : AppColors.backgroundOrange,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(category),
            GestureDetector(
              child: Icon(
                  is_selected ? Icons.do_not_disturb_on_outlined : Icons.add),
              onTap: () {
                shift_card(category);
              },
            )
          ],
        ));
  }
}

class ItemEditor extends StatefulWidget {
  Map<String, dynamic> item;
  ItemEditor({super.key, required this.item});

  @override
  State<ItemEditor> createState() => _ItemEditorState();
}

class _ItemEditorState extends State<ItemEditor> {
  // bool non_vegetarian = false;
  XFile? sampleImage;

  void shift_card(String category) {
    if (widget.item['categories'].contains(category)) {
      widget.item['categories'].remove(category);
      widget.item['unselected_categories'].add(category);
    } else {
      widget.item['categories'].add(category);
      widget.item['unselected_categories'].remove(category);
    }
    print(widget.item['categories']);
    print(widget.item['unselected_categories']);
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
    if (!widget.item.containsKey('name')) {
      widget.item['name'] = '';
    }
    if (!widget.item.containsKey('description')) {
      widget.item['description'] = '';
    }
    if (!widget.item.containsKey('price')) {
      widget.item['price'] = 0.0;
    }
    if (!widget.item.containsKey('veg')) widget.item['veg'] = false;

    if (!widget.item.containsKey('categories')) {
      widget.item['categories'] = [];
    }
    if (!widget.item.containsKey('unselected_categories')) {
      widget.item.addAll({'unselected_categories': all_categories.toList()});
    }
    return ExpansionTile(
      title: Text(widget.item['name'] == '' ? "New Item" : widget.item['name']),
      children: [
        x,
        SizedBox(
          child: TextFormField(
              onChanged: (name) {
                setState(() {
                  widget.item['name'] = name;
                });
              },
              initialValue: widget.item['name'],
              // controller: _name,
              decoration: const InputDecoration(
                icon: Icon(Icons.local_pizza),
                labelText: 'Item Name',
              )),
        ),
        SizedBox(
          child: TextFormField(
              onChanged: (price) {
                setState(() {
                  widget.item['price'] = double.parse(price);
                });
              },
              initialValue: widget.item['price'] == 0
                  ? ''
                  : widget.item['price'].toString(),
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
            const Text('Vegetarian'),
            Checkbox(
              value: widget.item['veg'],
              onChanged: (bool? val) {
                setState(() {
                  widget.item['veg'] = val;
                });
              },
            ),
          ],
        ),
        SizedBox(
          child: TextFormField(
              onChanged: (description) {
                setState(() {
                  widget.item['description'] = description;
                });
              },
              initialValue: widget.item['description'],
              maxLines: 2,
              decoration: const InputDecoration(
                icon: Icon(Icons.notes),
                labelText: 'Description',
              )),
        ),
        const Text('Tags'),
        const Text(
            'Tags help us show your menu items to relevant customers(improve this wording)'),
        Card(
          child: Wrap(
              children:
                  widget.item['categories'].toList().map<Widget>((category) {
            return CategoryCard(
              category: category,
              shift_card: shift_card,
              is_selected: true,
            );
          }).toList()),
        ),
        Wrap(
            children: widget.item['unselected_categories']
                .toList()
                .map<Widget>((category) {
          return CategoryCard(
            category: category,
            shift_card: shift_card,
            is_selected: false,
          );
        }).toList()),
      ],
    );
  }
}

class EditMenu extends StatefulWidget {
  final List<dynamic> menu;
  EditMenu({super.key, required this.menu});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  @override
  Widget build(BuildContext context) {
    print(widget.menu.runtimeType);
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: widget.menu.toList().map((item) {
                return ItemEditor(item: item);
              }).toList(),
            ),
            GestureDetector(
                onTap: () {
                  widget.menu.add(Map<String, dynamic>());
                  setState(() {});
                },
                child: Text('+Add another Item')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done")),
          ],
        ),
      ),
    );
  }
}

edit_menu({required List menu, required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => EditMenu(
              menu: menu,
            )),
  );
}
