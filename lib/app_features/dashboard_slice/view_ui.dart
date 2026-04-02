// ─── Zi_Slice: View ───────────────────────────────────────────────────────────
// ROLE: List screen only. No business logic. Reads ViewModel via ref.watch.
// RULE: Never call Repository directly. Only ViewModel + Controller.
// RENAME: XxxSliceView → YourFeatureView
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'a_dashboard_slice_io.dart';

class DashboardSliceView extends StatefulWidget {
  const DashboardSliceView({super.key});

  @override
  State<DashboardSliceView> createState() => _DashboardSliceViewState();
}

class _DashboardSliceViewState extends State<DashboardSliceView> {
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
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          return DashboardSliceTile(
            item: item,
            onTap: () {},
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
          final ctrl = XxxSliceController();

          final result = await ziFormView(
            context,
            title: 'Add Item',
            form: XxxSliceForm(
              ctrl,
              onSubmit: (name) async {
                ZiLogger.log("Create: $name");
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
