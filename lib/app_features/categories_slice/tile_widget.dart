// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
// RULE: Never read providers here. Pass data model as param.
// RULE: Actions widget handles all menu options — keep tile clean.
// RENAME: XxxSliceTile → YourFeatureTile
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

/// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
/// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
/// RULE: Never read providers here. Pass data model as param.
/// RULE: Actions widget handles all menu options — keep tile clean.
/// ─────────────────────────────────────────────────────────────────────────────

class CategoriesSliceTile extends StatelessWidget {
  final dynamic item; // your data model
  final VoidCallback onTap; // click callback
  final Widget actions; // actions widget (like menu buttons)

  const CategoriesSliceTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ZiColors.border)),
        ),
        child: Row(
          children: [
            Icon(Icons.category, size: 22, color: ZiColors.primary),
            ziGap(12),
            Expanded(
              child: Text(
                item.name ?? 'Unnamed',
                style: ZiTypoStyles.titleMd,
              ),
            ),
            actions,
          ],
        ),
      ),
    );
  }
}