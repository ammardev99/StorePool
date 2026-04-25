import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ShellDivider
// ─────────────────────────────────────────────────────────────────────────────

class ShellDivider extends StatelessWidget {
  const ShellDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(color: ZiColors.divider, height: 1, thickness: 1);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellSectionHeader
// ─────────────────────────────────────────────────────────────────────────────

class ShellSectionHeader extends StatelessWidget {
  const ShellSectionHeader({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: ZiColors.accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: ZiColors.primary),
        ),
        const SizedBox(width: 10),
        Text(label, style: ZiTypoStyles.titleMd),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellDescriptionCard  — tinted accent card for vision / info blocks
// ─────────────────────────────────────────────────────────────────────────────

class ShellDescriptionCard extends StatelessWidget {
  const ShellDescriptionCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ZiColors.accent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZiColors.primary.withValues( alpha:  0.15)),
      ),
      child: Text(text, style: ZiTypoStyles.bodyMd.copyWith(height: 1.7)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellInfoHeaderCard — icon + subtitle row card (used in Privacy / Terms)
// ─────────────────────────────────────────────────────────────────────────────

class ShellInfoHeaderCard extends StatelessWidget {
  const ShellInfoHeaderCard({
    super.key,
    required this.icon,
    required this.info,
  });

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ZiColors.accent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZiColors.primary.withValues( alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ZiColors.primarySoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: ZiColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              info,
              style: ZiTypoStyles.bodyMd.copyWith(height: 1.65),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellNumberedList — shared for Mission / Terms / Privacy items
// ─────────────────────────────────────────────────────────────────────────────

class ShellNumberedList extends StatelessWidget {
  const ShellNumberedList({super.key, required this.items});

  final List<String> items;

  static String _strip(String raw) {
    final i = raw.indexOf(': ');
    return (i != -1 && i <= 2) ? raw.substring(i + 2) : raw;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        items.length,
        (i) => _ShellNumberedItem(number: i + 1, text: _strip(items[i])),
      ),
    );
  }
}

class _ShellNumberedItem extends StatelessWidget {
  const _ShellNumberedItem({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZiColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZiColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color:
                  ZiColors
                      .primary, // won't work if primary is non-const — use getter fallback below
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: ZiTypoStyles.caption.copyWith(
                color: ZiColors.textWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                text,
                style: ZiTypoStyles.bodyMd.copyWith(height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellFeatureList — live + coming-soon feature rows
// ─────────────────────────────────────────────────────────────────────────────

class ShellFeatureList extends StatelessWidget {
  const ShellFeatureList({
    super.key,
    required this.items,
    required this.isComingSoon,
  });

  final List<String> items;
  final bool isComingSoon;

  static String _strip(String raw) {
    final i = raw.indexOf(': ');
    return (i != -1 && i <= 2) ? raw.substring(i + 2) : raw;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          items
              .map(
                (e) => _ShellFeatureItem(
                  text: _strip(e),
                  isComingSoon: isComingSoon,
                ),
              )
              .toList(),
    );
  }
}

class _ShellFeatureItem extends StatelessWidget {
  const _ShellFeatureItem({required this.text, required this.isComingSoon});

  final String text;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color:
            isComingSoon ? ZiColors.border.withValues( alpha: 0.4) : ZiColors.accent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isComingSoon
                ? Icons.schedule_rounded
                : Icons.check_circle_outline_rounded,
            size: 17,
            color: isComingSoon ? ZiColors.textMuted : ZiColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style:
                  isComingSoon
                      ? ZiTypoStyles.bodyMd.copyWith(
                        color: ZiColors.textMuted,
                      )
                      : ZiTypoStyles.bodyMd,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellContactList
// ─────────────────────────────────────────────────────────────────────────────

class ShellContactList extends StatelessWidget {
  const ShellContactList({super.key, required this.items});

  final List<String> items;

  static const Map<String, IconData> _iconMap = {
    'Phone': Icons.phone_outlined,
    'Email': Icons.email_outlined,
    'Website': Icons.language_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          items.map((item) {
            final parts = item.split(': ');
            final key = parts.first.trim();
            final value = parts.length > 1 ? parts.sublist(1).join(': ') : '';
            return _ShellContactItem(
              icon: _iconMap[key] ?? Icons.info_outline,
              label: key,
              value: value,
            );
          }).toList(),
    );
  }
}

class _ShellContactItem extends StatelessWidget {
  const _ShellContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ZiColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZiColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ZiColors.primarySoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 17, color: ZiColors.primary),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: ZiTypoStyles.caption),
              const SizedBox(height: 2),
              Text(
                value,
                style: ZiTypoStyles.titleSm.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ZiColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ShellDeveloperCredit
// ─────────────────────────────────────────────────────────────────────────────

class ShellDeveloperCredit extends StatelessWidget {
  const ShellDeveloperCredit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: ZiColors.divider)),
      ),
      child: Column(
        children: [
          Text(
            ShellData.appDevelopers.info,
            textAlign: TextAlign.center,
            style: ZiTypoStyles.caption,
          ),
          const SizedBox(height: 4),
          Text(
            ShellData.appDevelopers.title,
            textAlign: TextAlign.center,
            style: ZiTypoStyles.titleSm.copyWith(
              color: ZiColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
