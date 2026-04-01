// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController currentPassCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  final TextEditingController secQuestionCtrl = TextEditingController();
  final TextEditingController secAnswerCtrl = TextEditingController();
  bool isUpdateSecurityQA = false;

  @override
  void dispose() {
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    secQuestionCtrl.dispose();
    secAnswerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: ""),
      body: Form(
        child: ListView(
          children: [
            ZiSvgIcon(
              path: ShellSVGs.avSecure,
              color: ZiColors.primary,
              size: 80,
            ),

            heroSectionContent(
              title: ShellData.resetPassword.title,
              content: ShellData.resetPassword.info,
            ),
            ziGap(10),
            ZiInput(
              label: "Current Password",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: currentPassCtrl,
            ),
            ziGap(16),
            ZiInput(
              label: "New Password",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: newPassCtrl,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            ZiInput(
              label: "Confirm Password",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: confirmPassCtrl,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            Row(
              children: [
                ZiCheckbox(
                  value: isUpdateSecurityQA,
                  onChanged:
                      (value) => setState(() => isUpdateSecurityQA = value),
                ),
                ziGap(10),
                const Text("Update security question!"),
              ],
            ),

            if (isUpdateSecurityQA) ...[
              ziGap(16),
              ZiInput(
                label: "Security Question",
                variant: ZiInputVariant.stacked,
                controller: secQuestionCtrl,
              ),
              ziGap(16),
              ZiInput(
                label: "Secure Answer",
                variant: ZiInputVariant.stacked,
                controller: secAnswerCtrl,
              ),
            ],

            ziGap(16),

            ZiButtonB(
              expand: true,
              label: "Update Password",
              action: () {
                // TODO: Implement update password action
              },
            ),
          ],
        ),
      ),
    );
  }
}
