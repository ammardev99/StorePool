import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      backgroundColor: ZiColors.background,
      appBar: ZiAppBarB(title: ShellData.appPrivacyPolicy.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShellInfoHeaderCard(
              icon: Icons.shield_outlined,
              info: ShellData.appPrivacyPolicy.info,
            ),
            ziGap(24),
            if (ShellData.appPrivacyPolicy.items != null)
              ShellNumberedList(items: ShellData.appPrivacyPolicy.items!),
            ziGap(20),
            const ShellDeveloperCredit(),
            ziGap(24),
          ],
        ),
      ),
    );
  }
}
