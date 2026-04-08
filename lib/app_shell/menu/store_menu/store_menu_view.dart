// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:storepool/app_shell/menu/store_menu/store_sub_pages/pin_reset_store.dart';
import 'package:zi_core/zi_core_io.dart';

import '../../app_shell_io.dart';

class StoreMenuView extends StatelessWidget {
  const StoreMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // DO: Get store data from provider
    const storeName = 'No Store';
    const storeCategory = 'Create a store to get started';
    const hasStore = true;

    return ZiScaffoldB(
      showPagePadding: false,
      appBar: ZiAppBarB(title: "Store Setting"),
      body: Column(
        children: [
          ziGap(10),

          // ── store info card ───────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ZiColors.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: CircleAvatar(
                backgroundColor: ZiColors.primary,
                child: const Icon(
                  Icons.store_mall_directory_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text(storeName, style: ZiTypoStyles.titleLg),
              subtitle: Text(storeCategory, style: ZiTypoStyles.bodyMedium),
            ),
          ),

          ziGap(10),
          Divider(height: 2, color: ZiColors.border),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ── show create if no store ───────────────────────────────
                if (!hasStore)
                  ZiMenuTile1(
                    icon: Icons.add_business_rounded,
                    label: "Create New Store",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateStoreView()));
                        // DO: Navigate to CreateStoreView
                      },
                    ),
                  ),

                // ── store menu ────────────────────────────────────────────
                // ignore: dead_code
                if (hasStore) ...[
                  ZiMenuTile1(
                    icon: Icons.store_mall_directory_rounded,
                    label: "Edit Store Profile",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (_) => EditStoreView()));
                        // DO: Navigate to EditStoreView
                      },
                    ),
                  ),
                  ZiMenuTile1(
                    icon: Icons.lock,
                    label: "Reset Store PIN",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                                                                        Navigator.push(context, MaterialPageRoute(builder: (_) => PinResetStoreView()));
                        // DO: Navigate to PinResetStoreView
                      },
                    ),
                  ),
                ],

                ZiMenuTile1(
                  icon: Icons.help_rounded,
                  label: "Help & Support",
                  action: ZiTapAction(
                    type: ZiTapActionType.openUrl,
                    url:
                        "https://api.whatsapp.com/send/?phone=923424264494"
                        "&text=Hi,%20I%20need%20Help%20About%20"
                        "${ShellData.appInfo.title}%20App."
                        "&type=phone_number&app_absent=0",
                  ),
                ),

                // ── danger zone ───────────────────────────────────────────
                // ignore: dead_code
                if (hasStore) ...[
                  ZiMenuTile1(
                    icon: Icons.delete,
                    iconPrefixColor: ZiColors.lossR,
                    label: "Delete Store",

                    labelColor: ZiColors.lossR,
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () async{
                        bool? isconfirm = await ziConfirmationDialogResult(
                          context: context,
                          colorTone: ZiColors.lossR,
                          icon: Icons.delete,
                          actionOn: "Storepool",
                           actionLabel: "delete");

                        // DO: Implement delete store action
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
