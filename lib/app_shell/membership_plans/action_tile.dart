import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final String actionLabel;
  final bool? isGradient;
  final VoidCallback? onActionTap;

  const ActionTile({
    super.key,
    required this.title,
    this.actionLabel = "Add New",
    this.isGradient,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final useGradient = isGradient ?? (actionLabel.toLowerCase() == "upgrade");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: ZiColors.border,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: ZiTypoStyles.titleMd),

          if (onActionTap != null)
            Material(
              color: Colors.transparent, // Keeps parent background visible
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: ZiColors.accent,
                highlightColor: Colors.transparent,
                onTap: onActionTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: useGradient ? null : ZiColors.primary,
                    gradient: useGradient ? ZiColors.gradientTB : null,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Text(
                    actionLabel,
                    style: TextStyle(color: ZiColors.textWhite),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
