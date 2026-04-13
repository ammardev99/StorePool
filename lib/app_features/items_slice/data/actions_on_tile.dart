import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart';
import 'package:storepool/firebase_services/store/catalog_item_service.dart';
import 'package:zi_core/zi_core_io.dart';
import 'form.dart';

class CatalogItemTileActions extends StatelessWidget {
  final Map<String, dynamic> item;
  final String storeId; // ✅ dynamic

   CatalogItemTileActions({
    super.key,
    required this.item,
    required this.storeId,
  });

  final CatalogItemService _service = CatalogItemService();

  Future<void> _openEdit(BuildContext context) async {
    final res = await ziFormView(
      context,
      type: ZiFormViewType.page,
      title: 'Edit Item',
      form: CatalogForm(
        storeId: storeId,
        type: CatalogType.product,
        item: item,
      ),
    );

    // ignore: use_build_context_synchronously
    if (res == true) Navigator.pop(context, true);
  }

  Future<void> _delete(BuildContext context) async {
    final confirm = await ziConfirmationDialogResult(
      context: context,
      actionLabel: 'Delete',
      actionOn: item["title"] ?? '',
    );

    if (confirm != true) return;

    try {
      await _service.deleteItem(
        storeId: storeId,
        uuid: item["uuid"],
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted successfully')),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delete failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZiOverOptionsActionButton(
      title: item["title"] ?? '',
      actions: [
        ZiOverOptionsAction(
          icon: Icons.edit,
          label: 'Edit',
          onTap: () => _openEdit(context),
        ),
        ZiOverOptionsAction(
          icon: Icons.delete,
          label: 'Delete',
          isDanger: true,
          onTap: () => _delete(context),
        ),
      ],
    );
  }
}