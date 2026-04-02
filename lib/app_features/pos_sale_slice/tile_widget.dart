// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
// RULE: Never read providers here. Pass data model as param.
// RULE: Actions widget handles all menu options — keep tile clean.
// RENAME: XxxSliceTile → YourFeatureTile
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class POSSaleSliceTile extends StatelessWidget {
  final dynamic item;
  final VoidCallback onTap;
  final Widget actions;

  const POSSaleSliceTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name ?? ''),
      onTap: onTap,
      trailing: actions,
    );
  }
}
