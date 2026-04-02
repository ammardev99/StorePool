import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell/app_shell_io.dart';
import 'zi_slice/z_slice_io.dart';

class NameAppView extends StatefulWidget {
  const NameAppView({super.key});

  @override
  State<NameAppView> createState() => _NameAppViewState();
}

class _NameAppViewState extends State<NameAppView> {
  int pageIndex = 0;
  List mainPavesView = [XxxSliceView(), MenuView()];
  List<TabItem> mainPages = [
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
