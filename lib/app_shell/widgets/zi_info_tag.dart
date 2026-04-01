// lib/app_shell/widgets/zi_info_tag.dart

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ZiInfoTag extends StatelessWidget {
  final IconData? icon;
  final String?   tag;
  final String    value;
  final double    iconSize;

  const ZiInfoTag({
    super.key,
    required this.value,
    this.icon,
    this.tag,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize, color: ZiColors.textMuted),
          ziGap(2),
        ],
        if (tag != null) ...[
          Text(tag!, style: ZiTypoStyles.caption),
          ziGap(2),
        ],
        Text(value, style: ZiTypoStyles.tag),
        ziGap(8),
      ],
    );
  }
}