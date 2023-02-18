import 'dart:io';
import 'dart:math';

import 'package:campus_catalogue/constants/colors.dart';
import 'package:campus_catalogue/constants/typography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
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
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: AppColors.backgroundOrange)),
        // color: is_selected ? AppColors.signIn : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(category),
              GestureDetector(
                child: Icon(is_selected ? Icons.remove : Icons.add),
                onTap: () {
                  shift_card(category);
                },
              )
            ],
          ),
        ));
  }
}

class ItemEditor extends StatefulWidget {
  Map<String, dynamic> item;
  Function delete_item;
  ItemEditor({super.key, required this.item, required this.delete_item});

  @override
  State<ItemEditor> createState() => _ItemEditorState();
}

class _ItemEditorState extends State<ItemEditor> {
  // bool non_vegetarian = false;
  XFile? sampleImage;
  bool show_name = false;

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
    print('Built for ');
    print(widget.item);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.signIn,
      child: ExpansionTile(
        onExpansionChanged: ((value) {
          show_name = !value;
          setState(() {});
        }),
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        collapsedBackgroundColor: AppColors.signIn,
        iconColor: Colors.black,
        textColor: Colors.black,
        title: show_name
            ? Text(
                widget.item['name'] == '' ? "New Item" : widget.item['name'],
                style:
                    AppTypography.textMd.copyWith(fontWeight: FontWeight.w600),
              )
            : const Text(''),
        // title: Text(''),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.topLeft,
        children: [
          // x,
          const Align(
            child: Text('Item Name'),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            child: TextFormField(
                onChanged: (name) {
                  setState(() {
                    widget.item['name'] = name;
                  });
                },
                initialValue: widget.item['name'],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white)),
          ),
          SizedBox(
            height: 10,
          ),

          const Align(
            child: Text('Price'),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 5,
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
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white)),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,

              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: AppColors.backgroundOrange,
                  // fillColor: Colors.black,
                  activeColor: AppColors.backgroundYellow,

                  value: widget.item['veg'],
                  onChanged: (bool? val) {
                    setState(() {
                      widget.item['veg'] = val;
                    });
                  },
                ),
                const Text('Vegetarian'),
              ],
            ),
          ),
          const Align(
            child: Text('Description'),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 5,
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
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white)),
          ),
          SizedBox(
            height: 10,
          ),

          const Text('Relevant Tags'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: 60,

            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Wrap(
                  children: widget.item['categories']
                      .toList()
                      .map<Widget>((category) {
                return CategoryCard(
                  category: category,
                  shift_card: shift_card,
                  is_selected: true,
                );
              }).toList()),
            ),
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
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => {
                setState(
                  () {
                    widget.delete_item(widget.item);
                    setState(() {});
                  },
                )
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class EditMenu extends StatefulWidget {
  final List<dynamic> menu;

  EditMenu({super.key, required this.menu});
  @override
  State<EditMenu> createState() => _EditMenuState();
}

int itemcount = 0;

class _EditMenuState extends State<EditMenu> {
  void delete_item(item) {
    widget.menu.remove(item);
    setState(() {});
    initState();

    // var a = [];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.menu.runtimeType);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.backgroundYellow,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Add Food Items',
                style:
                    AppTypography.textMd.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
            ),
            widget.menu.isEmpty
                ? SizedBox(
                    child: Text(
                      "Empty Menu",
                      style: AppTypography.textMd,
                    ),
                    height: 50,
                  )
                : Column(
                    children: widget.menu.toList().map((item) {
                      if (!item.containsKey('key')) item['key'] = ++itemcount;
                      return ItemEditor(
                        key: ValueKey(item['key']),
                        item: item,
                        delete_item: delete_item,
                      );
                    }).toList(),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      widget.menu.add(Map<String, dynamic>());
                      setState(() {});
                    },
                    child: Text(
                      '+Add Item',
                      style: AppTypography.textMd
                          .copyWith(color: AppColors.backgroundOrange),
                      // style: TextStyle(color: AppColors.backgroundOrange,
                      // fontWeight: FontWeight.bold
                      // ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < widget.menu.length; i++) {
                    widget.menu[i].remove('unselected_categories');
                    widget.menu[i].remove('id');
                    print(widget.menu[i]);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundOrange,
                    minimumSize: const Size(221, 40)),
                child: const Text("Done")),
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
