import 'package:flutter/material.dart';
import 'package:storepool/app_features/categories_slice/data/actions_on_tile.dart';
import 'package:storepool/app_features/categories_slice/data/controller.dart';
import 'package:storepool/app_features/categories_slice/data/form.dart';
import 'package:storepool/app_features/categories_slice/tile_widget.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:storepool/firebase_services/store/catalog_category_service.dart';
import 'package:zi_core/zi_core_io.dart';

class CategoriesSliceView extends StatefulWidget {
  final String storeId;
  const CategoriesSliceView({super.key, required this.storeId});

  @override
  State<CategoriesSliceView> createState() => CategoriesSliceViewState();
}

class CategoriesSliceViewState extends State<CategoriesSliceView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  CatalogType activeType = CatalogType.product;

  List<CatalogCategoriesTableData> categories = [];
  Map<String, int> itemCounts = {};

  bool isLoading = false;

  final service = CatalogCategoryService();

  String get storeId => widget.storeId;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: CatalogType.values.length,
      vsync: this,
    );

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      activeType = CatalogType.values[tabController.index];
      load();
    });

    load();
  }

  // ─────────────────────────────────────────────────────────────
  // 🔥 FIREBASE LOADING
  // ─────────────────────────────────────────────────────────────
  Future<void> load() async {
    setState(() => isLoading = true);

    try {
      final data = await service.getCategories(
        storeId: storeId,
        type: activeType.name,
      );

      final parsed =
          data.map((e) => CatalogCategoriesTableData.fromMap(e)).toList();

      setState(() {
        categories = parsed;

        // optional placeholder counts (replace later with item aggregation)
        itemCounts = {for (final e in parsed) e.uuid: 0};

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        categories = [];
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
                  controller: tabController,
                  type: ZiTabBarType.filter,
                  tabs:
                      CatalogType.values
                          .map((e) => Tab(text: e.label))
                          .toList(),
                ),
                Text(
                  "${activeType.label}s List (${categories.length})",
                  style: ZiTypoStyles.titleSm,
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: RefreshIndicator(
              onRefresh: load,
              child:
                  isLoading && categories.isEmpty
                      ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(
                            height: 360,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      )
                      : categories.isEmpty
                      ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(
                            height: 360,
                            child: Center(child: ZiNotFoundStateInfo()),
                          ),
                        ],
                      )
                      : ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (_, i) {
                          final cat = categories[i];

                          return CategoriesSliceTile(
                            item: cat,
                            onTap: () {},
                            actions: ActionsOnCategory(
                              storeId: storeId,
                              category: cat,
                              itemCount: itemCounts[cat.uuid] ?? 0,
                              onActionCompleted: load,
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),

      floatingActionButton: ZiFABIconBtn(
        onTap: () async {
          final ctrl = CategoryController(
            storeId: storeId,
            formMode: ZiFormMode.add,
          )..selectedType = activeType;

          final result = await ziFormView(
            context,
            title: 'Add ${activeType.label} Category',
            form: CategoryForm(ctrl),
          );

          if (result == true) {
            load();
          }
        },
      ),
    );
  }
}
