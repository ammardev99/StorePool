// ─── Zi_Slice: Tile ───────────────────────────────────────────────────────────
// ROLE: Pure UI list tile. No logic. No ref. Callbacks only.
// RULE: Never read providers here. Pass data model as param.
// RULE: Actions widget handles all menu options — keep tile clean.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class OrderHistorySliceTile extends StatelessWidget {
  final dynamic item;       // your data model
  final VoidCallback onTap; // tap callback
  final Widget actions;     // trailing actions widget

  const OrderHistorySliceTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final String orderNumber = item['orderNumber'] ?? '#ORD-001';
    final int? itemCount = item['itemCount'] ?? 0;
    final String dateTime = item['dateTime'] ?? '03 Apr 2026, 2:30 PM';
    final double amount = item['amount']?.toDouble() ?? 0;
    final String currencySign = item['currencySign'] ?? 'Rs.';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ZiColors.border)),
        ),
        child: Row(
          children: [
            /// ICON BOX
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: ZiColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                color: ZiColors.primary,
                size: 20,
              ),
            ),

            ziGap(10),

            /// TEXT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ORDER + ITEM COUNT
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          orderNumber,
                          style: ZiTypoStyles.titleMd,
                        ),
                      ),
                      if (itemCount != null)
                        Text(
                          '$itemCount ${itemCount == 1 ? 'Item' : 'Items'}',
                          style: ZiTypoStyles.caption,
                        ),
                    ],
                  ),

                  ziGap(4),

                  /// DATE + AMOUNT
                  Row(
                    children: [
                      Text(dateTime, style: ZiTypoStyles.caption),
                      const Spacer(),
                      Text(
                        '$currencySign ${amount.toStringAsFixed(0)}',
                        style: ZiTypoStyles.titleSm.copyWith(
                          color: ZiColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// RIGHT SIDE ACTION
            actions,
          ],
        ),
      ),
    );
  }
}