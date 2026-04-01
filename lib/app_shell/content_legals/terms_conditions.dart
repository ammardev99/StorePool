// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class TermsConditionsPageView extends StatelessWidget {
  const TermsConditionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      backgroundColor: ZiColors.background,
      appBar: ZiAppBarB(title: ShellData.appTermsConditions.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShellInfoHeaderCard(
              icon: Icons.gavel_outlined,
              info: ShellData.appTermsConditions.info,
            ),
            ziGap(24),
            if (ShellData.appTermsConditions.items != null)
              ShellNumberedList(items: ShellData.appTermsConditions.items!),
            ziGap(20),
            const ShellDeveloperCredit(),
            ziGap(20),
          ],
        ),
      ),
    );
  }
}
