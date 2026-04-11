import 'package:flutter/material.dart';
import 'package:storepool/app_features/categories_slice/data/actions_on_tile.dart';
import 'package:storepool/app_features/categories_slice/data/controller.dart';
import 'package:storepool/app_features/categories_slice/data/form.dart';
import 'package:storepool/app_features/categories_slice/tile_widget.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:zi_core/zi_core_io.dart';

class CategoriesSliceView extends StatefulWidget {
  const CategoriesSliceView({super.key});

  @override
  State<CategoriesSliceView> createState() => _CategoriesSliceViewState();
}
  
class _CategoriesSliceViewState extends State<CategoriesSliceView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  CatalogType _activeType = CatalogType.product;

  List<CatalogCategoriesTableData> categories = [];
  Map<String, int> itemCounts = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: CatalogType.values.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      _activeType = CatalogType.values[_tabController.index];
      _load();
    });

    _load();
  }

  Future<void> _load() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 200));

    final data = _dummyData();

    setState(() {
      categories = data
          .where((e) => e.catalogType == _activeType.name)
          .toList();

      itemCounts = {
        for (final e in data) e.uuid: (e.uuid.hashCode % 8).abs()
      };

      isLoading = false;
    });
  }

  /// =========================
  /// 🟡 DUMMY DATA SOURCE
  /// =========================
  List<CatalogCategoriesTableData> _dummyData() {
    return const [
      CatalogCategoriesTableData(
        uuid: "1",
        name: "Electronics",
        catalogType: "product",
        isSystem: false,
      ),
      CatalogCategoriesTableData(
        uuid: "2",
        name: "Fashion",
        catalogType: "product",
        isSystem: false,
      ),
      CatalogCategoriesTableData(
        uuid: "3",
        name: "Grocery",
        catalogType: "product",
        isSystem: true,
      ),
      CatalogCategoriesTableData(
        uuid: "4",
        name: "Home Cleaning",
        catalogType: "service",
        isSystem: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      showPagePadding: false,
      appBar: ZiAppBarB(title: "Categories", centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZiTabBar(
                  controller: _tabController,
                  type: ZiTabBarType.filter,
                  tabs: CatalogType.values
                      .map((e) => Tab(text: e.label))
                      .toList(),
                ),
                Text(
                  "${_activeType.label}s List (${categories.length})",
                  style: ZiTypoStyles.titleSm,
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: isLoading && categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : categories.isEmpty
                    ? ZiNotFoundStateInfo()
                    : ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (_, i) {
                          final cat = categories[i];

                          return CategoriesSliceTile(
                            item: cat,
                            onTap: () {},
                            actions: ActionsOnCategory(
                              category: cat,
                              itemCount: itemCounts[cat.uuid] ?? 0,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),

      floatingActionButton: ZiFABIconBtn(
        onTap: () {
          final ctrl = CategoryController(
            formMode: ZiFormMode.add,
          )..selectedType = _activeType;

          ziFormView(
            context,
            title: 'Add ${_activeType.label} Category',
            form: CategoryForm(ctrl),
          );
        },
      ),
    );
  }
}