import 'package:flutter/material.dart';
import 'package:storepool/app_shell/menu/store_menu/store_sub_pages/pin_reset_store.dart';
import 'package:storepool/firebase_services/store/store_service.dart';
import 'package:zi_core/zi_core_io.dart';

import '../../app_shell_io.dart';

class StoreMenuView extends StatefulWidget {
  const StoreMenuView({super.key});

  @override
  State<StoreMenuView> createState() => _StoreMenuViewState();
}

class _StoreMenuViewState extends State<StoreMenuView> {
  final service = StoreService();

  String storeName = 'Loading...';
  String storeCategory = '';
  bool hasStore = false;
  bool isDeleting = false; // Loading for delete

  String? storeId;

  @override
  void initState() {
    super.initState();
    loadStore();
  }

  Future<void> loadStore() async {
    hasStore = await service.hasStore();

    if (hasStore) {
      final userStores = await service.getUserStores();
      final doc = userStores.isNotEmpty ? userStores.first : null;

      if (doc != null) {
        final data = doc.data() as Map<String, dynamic>;
        final metadata = data['metadata'] as Map<String, dynamic>;

        storeId = doc.id;
        storeName = metadata['name'] ?? '';
        storeCategory = metadata['category'] ?? '';
      }
    } else {
      storeName = 'No Store';
      storeCategory = 'Create a store to get started';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      showPagePadding: false,
      appBar: ZiAppBarB(title: "Store Setting"),
      body: Column(
        children: [
          ziGap(10),
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
              subtitle: Text(storeCategory, style: ZiTypoStyles.bodyMd),
            ),
          ),
          ziGap(10),
          Divider(height: 2, color: ZiColors.border),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (!hasStore)
                  ZiMenuTile1(
                    icon: Icons.add_business_rounded,
                    label: "Create New Store",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateStoreView()),
                        ).then((_) => loadStore());
                      },
                    ),
                  ),
                if (hasStore) ...[
                  ZiMenuTile1(
                    icon: Icons.store_mall_directory_rounded,
                    label: "Edit Store Profile",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditStoreView( storeId: storeId ?? "")),
                        ).then((_) => loadStore());
                      },
                    ),
                  ),
                  ZiMenuTile1(
                    icon: Icons.lock,
                    label: "Reset Store PIN",
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PinResetStoreView()),
                        );
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
                if (hasStore)
                  ZiMenuTile1(
                    icon: Icons.delete,
                    iconPrefixColor: ZiColors.lossR,
                    label: "Delete Store",
                    labelColor: ZiColors.lossR,
                    action: ZiTapAction(
                      type: ZiTapActionType.custom,
                      onTap: () async {
                        bool? isConfirm = await ziConfirmationDialogResult(
                          context: context,
                          colorTone: ZiColors.lossR,
                          icon: Icons.delete,
                          actionOn: "Storepool",
                          actionLabel: "delete",
                        );

                        if (isConfirm == true && storeId != null) {
                          setState(() => isDeleting = true);
                          await service.deleteStore(storeId!);
                          await loadStore();
                          setState(() => isDeleting = false);
                        }
                      },
                    ),
                    // trailing: isDeleting
                    //     ? SizedBox(
                    //         width: 24,
                    //         height: 24,
                    //         child: CircularProgressIndicator(
                    //           strokeWidth: 2,
                    //           color: ZiColors.lossR,
                    //         ),
                    //       )
                    //     : null,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}