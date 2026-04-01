import 'package:flutter/material.dart';
import 'package:storepool/app_features/zi_slice_1/zi_slice_io.dart';
import 'package:storepool/app_view/bottom_pages/dashboard.dart';
import 'package:zi_core/zi_core_io.dart';

import '../app_shell/app_shell_io.dart';

class StorePoolAppView extends StatefulWidget {
  const StorePoolAppView({super.key});

  @override
  State<StorePoolAppView> createState() => _StorePoolAppViewState();
}

class _StorePoolAppViewState extends State<StorePoolAppView> {
  int pageIndex = 0;
  List mainPavesView = [
    
    DashboardView(), 
    
    DashboardView(), 
    
    XxxSliceView(),
    MenuView(),
    
    ];
  List<TabItem> mainPages = [
    TabItem(icon: Icons.dashboard_rounded, title: 'Dashboard'),
    TabItem(icon: Icons.dashboard_rounded, title: 'D2'),
    TabItem(icon: Icons.dashboard_rounded, title: 'Slice 1'),
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
