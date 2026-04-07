import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class AnalyticsCard extends StatelessWidget {
  final String label;
  final String count;
  final Color backgroundColor;
  final Color labelColor;
  final Color countColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const AnalyticsCard({
    super.key,
    required this.label,
    required this.count,
    this.backgroundColor = ZiColors.grayLight,
    this.labelColor = ZiColors.textDark,
    this.countColor = Colors.black,
    this.borderRadius = 6,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: ZiTypoStyles.caption.copyWith(
            color: labelColor,
          )),
          ziGap(4),
          Text(count, style: ZiTypoStyles.noLg.copyWith(
            color: countColor,
          )),
        ],
      ),
    );

    final wrappedCard =
        onTap != null
            ? InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
              child: card,
            )
            : card;

    // 👇 Expanded ensures it takes equal width with siblings in Row
    return Expanded(child: wrappedCard);
  }
}