// ─── Zi_Slice: Actions ───────────────────────────────────────────────────────
// ROLE: Overflow menu for tile. Handles view/edit/delete navigation.
// RULE: Use ziFormView for view and edit — never Navigator.push directly.
// RULE: Always ziConfirmationDialogResult for delete.
// RULE: Reload list after edit — check return value of ziFormView.
// RENAME: XxxSliceActions → YourFeatureActions
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'controller.dart';
import 'form.dart';

class ItemsSliceOnActions extends StatelessWidget {
  final dynamic item;
  final Future<void> Function()? onReload;
  final Future<void> Function(String uuid)? onDelete;

  const ItemsSliceOnActions({
    super.key,
    required this.item,
    this.onReload,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ZiOverOptionsActionButton(
      title: item.name ?? 'Item',
      positionType: ZiOverOptionsPosition.bottomSheet,
      style: ZiOverOptionsStyle.defaults.copyWith(showItemBorder: true),
      actions: [
        // VIEW
        ZiOverOptionsAction(
          icon: Icons.visibility_rounded,
          label: 'View',
          onTap: () {
            final ctrl = ItemsSliceController(formMode: ZiFormMode.view)
              ..prefill(item);
            ziFormView(
              context,
              type: ZiFormViewType.page,
              title: 'Details',
              form: ItemsSliceForm(ctrl),
            );
          },
        ),

        // EDIT
        ZiOverOptionsAction(
          icon: Icons.edit_rounded,
          label: 'Edit',
          onTap: () async {
            final ctrl = ItemsSliceController(formMode: ZiFormMode.edit)
              ..prefill(item);

            final result = await ziFormView(
              context,
              type: ZiFormViewType.page,
              title: 'Edit',
              form: ItemsSliceForm(ctrl),
            );
            if (result == true && onReload != null) {
              await onReload!();
            }
          },
        ),

        // DELETE
        ZiOverOptionsAction(
          icon: Icons.delete_rounded,
          label: 'Delete',
          isDanger: true,
          onTap: () async {
            final confirm = await ziConfirmationDialogResult(
              context: context,
              actionLabel: 'Delete',
              icon: Icons.delete_rounded,
              colorTone: ZiColors.lossR,
            );

            if (confirm == true && onDelete != null) {
              await onDelete!(item.uuid);
              if (onReload != null) await onReload!();
            }
          },
        ),
      ],
    );
  }
}
