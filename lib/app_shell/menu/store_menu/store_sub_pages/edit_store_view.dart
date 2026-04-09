import 'package:flutter/material.dart';
import 'package:storepool/app_shell/a_controllers/store_controllers/editstore_controller.dart';
import 'package:storepool/app_shell/shell_utils/images.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:zi_core/zi_core_io.dart';

class EditStoreView extends StatefulWidget {
   final String storeId;
  const EditStoreView({super.key, required this.storeId});

  @override
  State<EditStoreView> createState() => _EditStoreViewState();
}

class _EditStoreViewState extends State<EditStoreView> {
  final controller = EditStoreController();
  String? storeId = ""; 

  @override
void initState() {
  super.initState();
  controller.loadStore(widget.storeId).then((_) {
    if (mounted) setState(() {}); 
  });
}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Edit Store Profile"),
      body: Form(
        child: ListView(
          children: [
            ZiSvgIcon(path: ShellSVGs.avShop, color: ZiColors.primary, size: 80),
            heroSectionContent(
              title: "Store Profile",
              content: "Keep Your Store Info Up to date.",
            ),
            ziGap(20),
            ZiInput(
              label: "Store Name",
              controller: controller.nameCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            Row(
              children: [
                Expanded(
                  child: ZiSelectB<StoreCategory>(
                    label: 'Category',
                    items: StoreCategory.values,
                    value: controller.selectedCategory,
                    itemLabel: (e) => e.label,
                    onChanged: (v) => setState(() => controller.setCategory(v!)),
                  ),
                ),
                ziGap(10),
                SizedBox(
                  width: 130,
                  child: ZiSelectB<StoreCurrency>(
                    label: 'Currency',
                    items: StoreCurrency.values,
                    value: controller.selectedCurrency,
                    itemLabel: (e) => e.label,
                    onChanged: (v) => setState(() => controller.setCurrency(v!)),
                  ),
                ),
              ],
            ),
            ziGap(16),
            ZiInput(label: "Phone", controller: controller.phoneCtrl),
            ziGap(16),
            ZiInput(label: "Address", controller: controller.addressCtrl),
            ziGap(20),
           ZiButtonB(
  expand: true,
  label: "Update Store Profile",
  loading: controller.isLoading,
  action: () async {
    await controller.updateStore(context, () => setState(() {}));
  },
),
          ],
        ),
      ),
    );
  }
}