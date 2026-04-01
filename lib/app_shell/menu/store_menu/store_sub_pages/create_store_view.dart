import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../../app_shell_io.dart';

class CreateStoreView extends StatefulWidget {
  const CreateStoreView({super.key});

  @override
  State<CreateStoreView> createState() => _CreateStoreViewState();
}

class _CreateStoreViewState extends State<CreateStoreView> {
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
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Create New Store"),
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
              content: "Create Your New Store.",
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
                //       // TODO: Handle category change
                //     },
                //   ),
                // ),
                ziGap(10),
                // SizedBox(
                //   width: 130,
                //   child: ZiSelectB<StoreCurrency>(
                //     label: 'Currency',
                //     items: StoreCurrency.values,
                //     value: selectedCurrency,
                //     itemLabel: (e) => e.label,
                //     onChanged: (v) {
                //       // TODO: Handle currency change
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
              'Fill All Input Fields to activate the button',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            ziGap(20),
            ZiButtonB(
              expand: true,
              label: "Create My Store",
              action: () {
                // TODO: Implement create store action
              },
            ),
            ziGap(10),
            ZiButtonB(
              label: 'Log Out',
              expand: true,
              variant: ZiButtonVariantB.outline,
              action: () {
                // TODO: Implement logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}
