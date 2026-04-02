import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../../app_shell_io.dart';

class EditStoreView extends StatefulWidget {
  const EditStoreView({super.key});

  @override
  State<EditStoreView> createState() => _EditStoreViewState();
}

class _EditStoreViewState extends State<EditStoreView> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  // StoreCategory selectedCategory = StoreCategory.retail;
  // StoreCurrency selectedCurrency = StoreCurrency.pkr;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DO: Prefill data from store
    // DO: Get last updated date

    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Edit Store Profile"),
      body: Form(
        child: ListView(
          children: [
            ZiSvgIcon(
              path: ShellSVGs.avShop,
              color: ZiColors.primary,
              size: 80,
            ),

            heroSectionContent(
              title: "Store Profile",
              content: "Keep Your Store Info Up to date.",
            ),
            ziGap(20),
            ZiInput(
              label: "Store Name",
              controller: nameCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Expanded(
                //   child: ZiSelectB<StoreCategory>(
                //     label: 'Category',
                //     items: StoreCategory.values,
                //     value: selectedCategory,
                //     itemLabel: (e) => e.label,
                //     onChanged: (v) {
                //       // DO: Handle category change
                //     },
                //   ),
                // ),
                // ziGap(10),
                // SizedBox(
                //   width: 130,
                //   child: ZiSelectB<StoreCurrency>(
                //     label: 'Currency',
                //     items: StoreCurrency.values,
                //     value: selectedCurrency,
                //     itemLabel: (e) => e.label,
                //     onChanged: (v) {
                //       // DO: Handle currency change
                //     },
                //   ),
                // ),
              ],
            ),
            ziGap(16),
            ZiInput(
              label: "Phone",
              controller: phoneCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            ZiInput(
              label: "Address",
              controller: addressCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(10),
            const Text(
              'Last updated',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
            ),
            ziGap(20),
            ZiButtonB(
              expand: true,
              label: "Update Store Profile",
              action: () {
                // DO: Implement update store action
              },
            ),
          ],
        ),
      ),
    );
  }
}
