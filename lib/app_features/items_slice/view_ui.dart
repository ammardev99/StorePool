import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:storepool/app_features/items_slice/data/form.dart';
import 'package:storepool/app_features/items_slice/tile_widget.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart';
import 'package:storepool/firebase_services/store/catalog_item_service.dart';
import 'package:zi_core/zi_core_io.dart';

class ItemsSliceView extends StatefulWidget {
  const ItemsSliceView({super.key});

  @override
  State<ItemsSliceView> createState() => _ItemsSliceViewState();
}

class _ItemsSliceViewState extends State<ItemsSliceView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final CatalogItemService _service = CatalogItemService();

  CatalogType _activeType = CatalogType.product;

  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  String? storeId; // ✅ dynamic now

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

      _loadItems();
    });

    _initStoreAndLoad();
  }

  // ✅ get storeId from logged in user
  Future<void> _initStoreAndLoad() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User not logged in')));
        setState(() => _loading = false);
        return;
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      final stores = userDoc.data()?['stores_owned'];

      if (stores == null || stores.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No store found')));
        setState(() => _loading = false);
        return;
      }

      storeId = stores[0]; // ✅ first store

      await _loadItems();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load store')));
      setState(() => _loading = false);
    }
  }

  Future<void> _loadItems() async {
    if (storeId == null) return;

    setState(() => _loading = true);

    try {
      final data = await _service.getItems(
        storeId: storeId!,
        type: _activeType.name,
      );

      setState(() => _items = data);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load items')));
    }

    setState(() => _loading = false);
  }

  String get _currencySign => 'Rs.';

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Items Catalogs", centerTitle: true),
      showPagePadding: true,
      body: Column(
        children: [
          ZiTabBar(
            controller: _tabController,
            type: ZiTabBarType.filter,
            tabs:
                CatalogType.values
                    .map((type) => Tab(text: type.label))
                    .toList(),
          ),
          Expanded(
            child:
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _items.isEmpty
                    ? ZiNotFoundStateInfo()
                    : RefreshIndicator(
                      onRefresh: _loadItems,
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (_, index) {
                          final item = _items[index];

                          return CatalogItemTile(
                            item: item,
                            categoryName: item["categoryUuid"] ?? '',
                            currencySign: _currencySign,
                            storeId: storeId!, // ✅ PASS HERE
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
      floatingActionButton: ZiFABIconBtn(
        onTap: () async {
          if (storeId == null) return;

          final res = await ziFormView(
            context,
            type: ZiFormViewType.page,
            title: 'Add ${_activeType.label}',
            form: CatalogForm(storeId: storeId!, type: _activeType),
          );

          if (res == true) _loadItems();
        },
      ),
    );
  }
}
