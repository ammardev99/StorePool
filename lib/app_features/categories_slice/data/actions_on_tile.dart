import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:zi_core/zi_core_io.dart';
import 'form.dart';
import 'controller.dart';
class ActionsOnCategory extends StatelessWidget {
  final CatalogCategoriesTableData category;
  final int itemCount;

  const ActionsOnCategory({
    super.key,
    required this.category,
    required this.itemCount,
  });

  void openPage(BuildContext context, ZiFormMode mode) {
    final ctrl = CategoryController(
      storeId: "YOUR_STORE_ID", // 🔥
      formMode: mode,
    )..prefill(category);

    ziFormView(
      context,
      title: mode == ZiFormMode.view
          ? 'Category Details'
          : 'Edit Category',
      form: CategoryForm(ctrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = CategoryController(storeId: "YOUR_STORE_ID");

    return ZiOverOptionsActionButton(
      title: category.name,
      positionType: ZiOverOptionsPosition.native,
      actions: [
        ZiOverOptionsAction(
          icon: Icons.visibility_rounded,
          label: 'View',
          onTap: () => openPage(context, ZiFormMode.view),
        ),
        if (!category.isSystem) ...[
          ZiOverOptionsAction(
            icon: Icons.edit_rounded,
            label: 'Edit',
            onTap: () => openPage(context, ZiFormMode.edit),
          ),
          ZiOverOptionsAction(
            icon: Icons.delete_rounded,
            label: 'Delete',
            isDanger: true,
            onTap: () async {
              final confirm = await ziConfirmationDialogResult(
                context: context,
                actionLabel: 'Delete Category',
                actionOn: category.name,
                icon: Icons.delete_rounded,
                colorTone: ZiColors.lossR,
              );

              if (confirm == true) {
                await ctrl.delete(category.uuid);
              }
            },
          ),
        ],
      ],
    );
  }
}