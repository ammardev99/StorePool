// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
// RULE: Never read providers here. Pass data model as param.
// RULE: Actions widget handles all menu options — keep tile clean.
// RENAME: XxxSliceTile → YourFeatureTile
// ─────────────────────────────────────────────────────────────────────────────

// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
// RULE: Never read providers here. Pass data model as param.
// RULE: Actions widget handles all menu options — keep tile clean.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ItemsSliceTile extends StatelessWidget {
  final dynamic item;       // your data model
  final VoidCallback onTap; // tap callback
  final Widget actions;     // trailing actions widget

  const ItemsSliceTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = item['isActive'] ?? true;

    return InkWell(
      onTap: isActive ? onTap : null,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ZiColors.border)),
          ),
          child: Row(
            children: [
              /// LEFT SIDE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE + STATUS
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['title'] ?? 'Unnamed Service',
                            style: ZiTypoStyles.titleMd,
                          ),
                        ),
                        if (!isActive)
                          Text(
                            'Inactive',
                            style: ZiTypoStyles.caption.copyWith(
                              color: ZiColors.error,
                            ),
                          ),
                      ],
                    ),

                    ziGap(4),

                    /// CATEGORY + PRICE
                    Row(
                      children: [
                        Text(
                          'ID: ${item['id'] ?? 1}',
                          style: ZiTypoStyles.caption,
                        ),
                        ziGap(6),
                        const Icon(Icons.category, size: 16, color: ZiColors.gray),
                        ziGap(6),
                        Text(
                          item['categoryName'] ?? 'Services',
                          style: ZiTypoStyles.caption,
                        ),
                        const Spacer(),
                        Text(
                          'Rs ${item['price'] ?? 0}',
                          style: ZiTypoStyles.titleSm.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              /// RIGHT SIDE ACTIONS
              // actions,
            ],
          ),
        ),
      ),
    );
  }
}