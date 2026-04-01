import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_shell_io.dart';

class FAQsView extends StatelessWidget {
  const FAQsView({super.key});
  // later -add a search bar

  @override
  Widget build(BuildContext context) {
    final groups = FAQsGroup.values;

    return ZiScaffoldB(
      safeArea: true,
      appBar: ZiAppBarB(title: "FAQs"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:
            groups.map((group) {
              final items =
                  listFAQs
                      .where((e) => e.typeFAQ == group && !e.isDisable)
                      .toList();
              if (items.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name.toUpperCase(), style: ZiTypoStyles.caption),
                  const SizedBox(height: 8),
                  ...items.map((faq) => _FAQTile(faq: faq)),
                  // ...items.map((faq) => ),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
      ),
    );
  }
}

class _FAQTile extends StatelessWidget {
  final FAQsModel faq;

  const _FAQTile({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ExpansionTile(
        title: Text(faq.question, style: ZiTypoStyles.inputLabel),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [Text(faq.answer, style: ZiTypoStyles.bodyMedium)],
      ),
    );
  }
}
