import 'package:flutter/material.dart';
import 'package:storepool/app_shell/shell_utils/images.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:zi_core/zi_core_io.dart';

class CreateStoreView extends StatelessWidget {
  const CreateStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy controllers for UI only
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    StoreCategory selectedCategory = StoreCategory.values.first;
    StoreCurrency selectedCurrency = StoreCurrency.values.first;

    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Create New Store"),
      body: ListView(
        
        children: [
          heroSectionContent(
            img: ShellImages.logo,
            title: "Store Profile",
            content: "Create Your New Store.",
          ),
          ziGap(20),
          ZiInput(
            label: "Store Name",
            controller: nameCtrl,
            variant: ZiInputVariant.stacked,
          ),
          ziGap(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ZiSelectB<StoreCategory>(
                  label: 'Category',
                  items: StoreCategory.values,
                  value: selectedCategory,
                  itemLabel: (e) => e.label,
                  onChanged: (v) {},
                ),
              ),
              ziGap(10),
              SizedBox(
                width: 130,
                child: ZiSelectB<StoreCurrency>(
                  label: 'Currency',
                  items: StoreCurrency.values,
                  value: selectedCurrency,
                  itemLabel: (e) => e.label,
                  onChanged: (v) {},
                ),
              ),
            ],
          ),
          ziGap(16),
          ZiInput(
            label: "Phone",
            controller: phoneCtrl,
            variant: ZiInputVariant.stacked,
          ),
          ziGap(16),
          ZiInput(
            label: "Address",
            controller: addressCtrl,
            variant: ZiInputVariant.stacked,
          ),
          ziGap(10),
          Text(
            'Fill All Input Fields to activate the button',
            style: ZiTypoStyles.caption,
            textAlign: TextAlign.center,
          ),
          ziGap(20),
          ZiButtonB(
            expand: true,
            label: "Create My Store",
            action: () {},
          ),
          // ziGap(10),
          // ZiButtonB(
          //   label: 'Log Out',
          //   expand: true,
          //   variant: ZiButtonVariantB.outline,
          //   action: () {},
          // ),
        ],
      ),
    );
  }
}