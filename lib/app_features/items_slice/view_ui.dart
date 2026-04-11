// ─── Zi_Slice: View (UI ONLY - NORMALIZED) ───────────────────────────────────
// ROLE: Pure UI with dummy data. No state management, no services.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:storepool/app_features/items_slice/data/form.dart';
import 'package:storepool/app_features/items_slice/tile_widget.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart';
import 'package:zi_core/zi_core_io.dart';



class ItemsSliceView extends StatefulWidget {
  const ItemsSliceView({super.key});

  @override
  State<ItemsSliceView> createState() => _ItemsSliceViewState();
}

class _ItemsSliceViewState extends State<ItemsSliceView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  CatalogType _activeType = CatalogType.product;

  // ─── DUMMY DATA ───────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _items = [
    {
      "name": "Product 1",
      "price": 120,
      "categoryUuid": "cat1",
    },
    {
      "name": "Product 2",
      "price": 250,
      "categoryUuid": "cat2",
    },
    {
      "name": "Service 1",
      "price": 500,
      "categoryUuid": "cat1",
    },
  ];

  final Map<String, String> _categories = {
    "cat1": "Category A",
    "cat2": "Category B",
  };

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: CatalogType.values.length,
      vsync: this,
      initialIndex: _activeType.index,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      setState(() {
        _activeType = CatalogType.values[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getCategoryName(String uuid) {
    return _categories[uuid] ?? '';
  }

  String get _currencySign => 'Rs.';

  @override
  Widget build(BuildContext context) {
    // filter dummy data by tab
    final items =
        _items.where((e) {
          if (_activeType == CatalogType.product) {
            return e["name"].toString().contains("Product");
          } else {
            return e["name"].toString().contains("Service");
          }
        }).toList();

    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Items Catalogs", centerTitle: true),
      showPagePadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Tab Bar ─────────────────────────────────────────────
                ZiTabBar(
                  controller: _tabController,
                  type: ZiTabBarType.filter,
                  tabs: CatalogType.values
                      .map((type) => Tab(text: type.label))
                      .toList(),
                ),

                Text(
                  "${_activeType.label}s List (${items.length})",
                  style: ZiTypoStyles.titleSm,
                ),
              ],
            ),
          ),
          const Divider(),

          // ── List ────────────────────────────────────────────────────
          Expanded(
            child: items.isEmpty
                ? ZiNotFoundStateInfo()
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final item = items[index];

                      return CatalogItemTile(
                        item: item, // still passing (UI untouched)
                        categoryName:
                            _getCategoryName(item["categoryUuid"]),
                        currencySign: _currencySign,
                      );
                    },
                  ),
          ),
        ],
      ),

      // ── FAB ───────────────────────────────────────────────────────
      floatingActionButton: ZiFABIconBtn(
        onTap: () {
          // Only UI navigation (no controller)
          ziFormView(
            context,
            type: ZiFormViewType.page,
            title: 'Add ${_activeType.label}',
            form: CatalogForm()// dummy
          );
        },
      ),
    );
  }
}