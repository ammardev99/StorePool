





import 'package:flutter/material.dart';
import 'package:storepool/app_shell/a_controllers/store_controllers/createstore_controller.dart';
import 'package:storepool/app_shell/shell_utils/images.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:zi_core/zi_core_io.dart';

class CreateStoreView extends StatefulWidget {
  const CreateStoreView({super.key});

  @override
  State<CreateStoreView> createState() => _CreateStoreViewState();
}

class _CreateStoreViewState extends State<CreateStoreView> {
  final controller = CreateStoreController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
void showSnack(String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            controller: controller.nameCtrl,
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
                  value: controller.selectedCategory,
                  itemLabel: (e) => e.label,
                  onChanged: (v) {
                    setState(() {
                      controller.setCategory(v!);
                    });
                  },
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
                  onChanged: (v) {
                    setState(() {
                      controller.setCurrency(v!);
                    });
                  },
                ),
              ),
            ],
          ),
          ziGap(16),
          ZiInput(
            label: "Phone",
            controller: controller.phoneCtrl,
            variant: ZiInputVariant.stacked,
          ),
          ziGap(16),
          ZiInput(
            label: "Address",
            controller: controller.addressCtrl,
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
            loading: controller.isLoading,
            label: "Create My Store",
            action: () {
              controller.createStore(context);
            },
          ),
        ],
      ),
    );
  }
}