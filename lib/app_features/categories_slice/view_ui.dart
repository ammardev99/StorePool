// ─── Zi_Slice: View ───────────────────────────────────────────────────────────
// ROLE: List screen only. No business logic. Reads ViewModel via ref.watch.
// RULE: Never call Repository directly. Only ViewModel + Controller.
// RENAME: XxxSliceView → YourFeatureView
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'a_categories_slice_io.dart';

class CategoriesSliceView extends StatefulWidget {
  const CategoriesSliceView({super.key});

  @override
  State<CategoriesSliceView> createState() => _CategoriesSliceViewState();
}

class _CategoriesSliceViewState extends State<CategoriesSliceView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    ZiLogger.log("Loading items...");
    // TODO: fetch from API
    setState(() {});
  }

  Future<void> _delete(String uuid) async {
    ZiLogger.log("Delete: $uuid");
    // TODO: delete via API
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          return CategoriesSliceTile(
            item: item,
            onTap: () async {
              // Edit flow
              final ctrl = CategoriesSliceController();
              ctrl.prefill(item);

              final result = await ziFormView(
                context,
                title: 'Edit Category',
                form: CategoriesSliceForm(
                  ctrl,
                  onUpdate: (uuid, name, type, sort, active) async {
                    ZiLogger.log("Update: $uuid → $name ($type, $sort, $active)");
                    return true;
                  },
                ),
              );

              if (result == true) _load();
            },
            actions: XxxSliceActions(
              item: item,
              onReload: _load,
              onDelete: _delete,
            ),
          );
        },
      ),
      floatingActionButton: ZiFABIconBtn(
        onTap: () async {
          // Add new category
          final ctrl = CategoriesSliceController();

          final result = await ziFormView(
            context,
            title: 'Add Category',
            form: CategoriesSliceForm(
              ctrl,
              onSubmit: (name, type, sort, active) async {
                ZiLogger.log("Create: $name ($type, $sort, $active)");
                return true;
              },
            ),
          );

          if (result == true) _load();
        },
      ),
    );
  }
}