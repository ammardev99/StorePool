import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class CategoriesSliceTile extends StatelessWidget {
  final dynamic item;
  final VoidCallback onTap;
  final Widget actions;

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