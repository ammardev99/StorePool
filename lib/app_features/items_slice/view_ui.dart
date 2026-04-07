// ─── Zi_Slice: View ───────────────────────────────────────────────────────────
// ROLE: List screen only. No business logic. Reads ViewModel via ref.watch.
// RULE: Never call Repository directly. Only ViewModel + Controller.
// RENAME: XxxSliceView → YourFeatureView
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'a_items_slice_io.dart';

class ItemsSliceView extends StatefulWidget {
  const ItemsSliceView({super.key});

  @override
  State<ItemsSliceView> createState() => _ItemsSliceViewState();
}

class _ItemsSliceViewState extends State<ItemsSliceView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    ZiLogger.log("Loading items...");
    // DO: fetch from API
    setState(() {});
  }

  Future<void> _delete(String uuid) async {
    ZiLogger.log("Delete: $uuid");
    // DO: delete API
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body: ItemsSliceTile(
        item: {
          'title': 'Hair Cutting',
          'categoryName': 'Salon Services',
          'price': 500,
          'id': 1,
          'isActive': true,
        },
        onTap: () {
          debugPrint("Service tapped");
        },
        actions: IconButton(
          onPressed: () {
            ItemsSliceOnActions(
              // ✅ HERE
              item: {
                'title': 'Hair Cutting',
                'categoryName': 'Salon Services',
                'price': 500,
                'id': 1,
                'isActive': true,
              },
              onReload: _load,
              onDelete: _delete,
            );
          },
          // onPressed: () {
          //   ItemsSliceOnActions(
          //     // ✅ HERE
          //     item: {
          //       'title': 'Hair Cutting',
          //       'categoryName': 'Salon Services',
          //       'price': 500,
          //       'id': 1,
          //       'isActive': true,
          //     },
          //     onReload: _load,
          //     onDelete: _delete,
          //   );
          // },
          icon:  Icon(Icons.more_vert_rounded, color: ZiColors.primary,),
        ),
      ),
      // ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (_, i) {
      //     final item = items[i];
      //     return ItemsSliceTile(
      //       item: item,
      //       onTap: () {},
      //       actions: ItemsSliceActions(
      //         item: item,
      //         onReload: _load,
      //         onDelete: _delete,
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: ZiFABIconBtn(
        onTap: () async {
          final ctrl = ItemsSliceController();

          final result = await ziFormView(
            context,
            title: 'Add Item',
            form: ItemsSliceForm(
              ctrl,
              onSubmit: (name, category, type, price, active) async {
                // 🔹 Here you can call your API or backend to create the item
                ZiLogger.log(
                  "Create Item → Name: $name, Category: $category, Type: $type, Price: $price, Active: $active",
                );

                // Simulate successful save
                return true;
              },
            ),
          );

          if (result == true)
            _load(); // reload your list after successful creation
        },
      ),
    );
  }
}
