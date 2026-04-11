// ─── Zi_Slice: Actions (UI ONLY - NORMALIZED) ───────────────────────────
// ROLE: Overflow menu UI only. No backend, no providers.
// ───────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'form.dart';

class CatalogItemTileActions extends StatelessWidget {
  final Map<String, dynamic> item;

  const CatalogItemTileActions({super.key, required this.item});

  // ─── view ─────────────────────────────────────────────────────────────
  Future<void> _openView(BuildContext context) async {
    await ziFormView(
      context,
      title: 'Item Details',
      form: const CatalogForm(),
    );
  }

  // ─── edit ─────────────────────────────────────────────────────────────
  Future<void> _openEdit(BuildContext context) async {
    await ziFormView(
      context,
      type: ZiFormViewType.page,
      title: 'Edit Item',
      form: const CatalogForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ZiOverOptionsActionButton(
      title: item["title"] ?? '',
      style: ZiOverOptionsStyle.defaults.copyWith(showItemBorder: true),
      actions: [
        ZiOverOptionsAction(
          icon: Icons.visibility_rounded,
          label: 'View',
          onTap: () => _openView(context),
        ),
        ZiOverOptionsAction(
          icon: Icons.edit_rounded,
          label: 'Edit',
          onTap: () => _openEdit(context),
        ),

        // ── Delete (UI only) ───────────────────────────────
        ZiOverOptionsAction(
          icon: Icons.delete_rounded,
          label: 'Delete',
          isDanger: true,
          onTap: () async {
            final confirm = await ziConfirmationDialogResult(
              context: context,
              actionLabel: 'Delete',
              actionOn: item["title"] ?? '',
              icon: Icons.delete_rounded,
              colorTone: ZiColors.lossR,
            );

            if (confirm == true) {
              // UI only — no backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Deleted (UI only)')),
              );
            }
          },
        ),
      ],
    );
  }
}