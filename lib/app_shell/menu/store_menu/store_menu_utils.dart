// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

import '../../app_shell_io.dart';

enum StoreMenuGroup { userAccount, settings, support, other, appShell, store }

// Menu Model
class StoreMenuModel {
  final IconData prefix;
  final String label;
  final StoreMenuGroup group;
  // final MenuState state;
  final ZiTapAction action;

  const StoreMenuModel({
    required this.prefix,
    required this.label,
    required this.group,
    // this.state = MenuState.enabled,
    required this.action,
  });
}

// Menu List
final List<StoreMenuModel> storeMenuList = [
  // Edit Store Profile
  // StoreMenuModel(
  //   prefix: Icons.store_mall_directory_rounded,
  //   label: 'Create New Store',
  //   group: StoreMenuGroup.userAccount,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: CreateStoreView(),
  //   ),
  // ),

  // StoreMenuModel(
  //   prefix: Icons.store_mall_directory_rounded,
  //   label: 'Edit Store Profile',
  //   group: StoreMenuGroup.userAccount,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: EditStoreView(),
  //   ),
  // ),
  // // Reset PIN
  // StoreMenuModel(
  //   prefix: Icons.lock,
  //   label: 'Reset Store PIN',
  //   group: StoreMenuGroup.userAccount,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: PinResetStoreView(),
  //   ),
  // ),
  // Rate App
  StoreMenuModel(
    prefix: Icons.help_rounded,
    label: 'Help & Support',
    group: StoreMenuGroup.appShell,
    action: ZiTapAction(
      type: ZiTapActionType.openUrl,
      url:
          "https://api.whatsapp.com/send/?phone=923424264494&text=Hi,%20I%20need%20Help%20About%20${ShellData.appInfo.title}%20App.&type=phone_number&app_absent=0",
    ),
  ),
];

// ----------------- Featch Store Menu -----------------//
Widget buildGroupedStoreMenu(
  BuildContext context, {
  List<StoreMenuGroup>? groups,
  bool showGroupTitle = true,
}) {
  final effectiveGroups = groups ?? StoreMenuGroup.values;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        effectiveGroups.map((group) {
          final items =
              storeMenuList
                  // .where((e) => e.group == group && e.state != MenuState.hidden)
                  .where((e) => e.group == group)
                  .toList();

          if (items.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showGroupTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, bottom: 4),
                  child: Text(
                    group.name.toUpperCase(),
                    style: ZiTypoStyles.caption,
                  ),
                ),
              ...items.map((item) {
                return ZiMenuTile1(
                  icon: item.prefix,
                  iconPrefixColor:
                      item.label == "Logout" ? Colors.red : Colors.grey,
                  label: item.label,
                  action: item.action,
                  // enabled: item.state == MenuState.enabled,
                  // action:  item.state == MenuState.enabled ? item.action : null,
                );
              }),
            ],
          );
        }).toList(),
  );
}
