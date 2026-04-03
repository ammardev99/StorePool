import 'package:flutter/material.dart';
import 'package:storepool/app_features/order_history_slice/view_ui.dart';

import 'package:zi_core/zi_core_io.dart';
import '../app_shell/app_shell_io.dart';
import 'categories_slice/a_categories_slice_io.dart';
import 'dashboard_slice/a_dashboard_slice_io.dart';
import 'items_slice/a_items_slice_io.dart';

class StorePoolAppView extends StatefulWidget {
  const StorePoolAppView({super.key});

  @override
  State<StorePoolAppView> createState() => _StorePoolAppViewState();
}

class _StorePoolAppViewState extends State<StorePoolAppView> {
  int pageIndex = 0;
  List mainPavesView = [
    // Bottom bar
    // - Dashboard,
    DashboardSliceView(),
    // - Categories,
    CategoriesSliceView(),
    // - Items,
    ItemsSliceView(),

    // - Web,
    // - Orders,
    // OrdersSliceView(),
    OrderHistorySliceView(),
    // - Menu
    MenuView(),
  ];
  List<TabItem> mainPages = [
    //     Bottom bar
    // - Dashboard,
    TabItem(icon: Icons.dashboard, title: 'Dashboard'),
    // - Categories,
    TabItem(icon: Icons.category, title: 'Categories'),
    // - Items,
    TabItem(icon: Icons.list, title: 'Items'),

    // - Web,
    // - Orders,
    TabItem(icon: Icons.shopping_cart, title: 'Orders'),
    // - Menu
    TabItem(icon: Icons.menu, title: 'Menu'),
  ];

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      showPagePadding: false,
      body: mainPavesView[pageIndex],
      bottomNavigationBar: ZiBottomBar(
        items: mainPages,
        currentIndex: pageIndex,
        onTap: (i) => setState(() => pageIndex = i),
        type: ZiBottomBarType.divider,
        style: ZiBottomBarStyle(
          backgroundColor: ZiColors.white,
          color: ZiColors.textMuted,
          colorSelected: ZiColors.primary,
        ),
      ),
    );
  }
}
