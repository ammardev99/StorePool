import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class POSSaleSliceTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const POSSaleSliceTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final int qty = item["qty"];
    final int price = item["price"];
    final int total = qty * price;

    return Material(
      color: ZiColors.white,
      child: Column(
        children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT SIDE (TITLE + PHONE)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: ZiTypoStyles.noLg.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ziGap(4),
                      Text(
                        item["phone"],
                        style: ZiTypoStyles.bodyMd.copyWith(
                          color: ZiColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),

                /// RIGHT SIDE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// TOP CONTROLS ROW
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// MINUS
                        _boxButton(
                          icon: Icons.remove,
                          color: ZiColors.grayLight,
                          onTap: onDecrease,
                        ),

                        ziGap(6),

                        /// QTY
                        Text(
                          qty.toString(),
                          style: ZiTypoStyles.bodyMd.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        ziGap(6),

                        /// PLUS
                        _boxButton(
                          icon: Icons.add,
                          color: Colors.green.shade100,
                          iconColor: Colors.green,
                          onTap: onIncrease,
                        ),

                        ziGap(8),

                        /// MULTIPLY TEXT
                        Text(
                          "$qty x $price",
                          style: ZiTypoStyles.bodyMd.copyWith(
                            color: ZiColors.textMuted,
                          ),
                        ),

                        ziGap(8),

                        /// DELETE
                        InkWell(
                          onTap: onDelete,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    ziGap(6),

                    /// TOTAL PRICE
                    Text(
                      "Rs $total",
                      style: ZiTypoStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// DIVIDER (IMPORTANT)
        Divider(
          height: 1,
          thickness: 1,
          color: ZiColors.border,
        ),
      ],
    ),
  );
}

  /// SMALL SQUARE BUTTON
  Widget _boxButton({
    required IconData icon,
    required Color color,
    Color iconColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }
}