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
  final controller = ResetPasswordController();

  @override
  void dispose() {
    controller.dispose();
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
              controller: controller.currentPassCtrl,
                onChanged: (_) => setState(() {}), // ✅ ADD THIS

            ),

            ziGap(16),

            ZiInput(
              label: "New Password",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: controller.newPassCtrl,
              onChanged: (_) => setState(() {}),
            ),

            ziGap(16),

            ZiInput(
              label: "Confirm Password",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: controller.confirmPassCtrl,
              onChanged: (_) => setState(() {}),
            ),

            ziGap(16),

            Row(
              children: [
                ZiCheckbox(
                  value: controller.isUpdateSecurityQA,
                  onChanged: (value) {
                    controller.toggleSecurityQA(value);
                    setState(() {});
                  },
                ),
                ziGap(10),
                const Text("Update security question!"),
              ],
            ),

            if (controller.isUpdateSecurityQA) ...[
              ziGap(16),
              ZiInput(
                label: "Security Question",
                variant: ZiInputVariant.stacked,
                controller: controller.secQuestionCtrl,
                  onChanged: (_) => setState(() {}), // ✅ ADD

              ),
              ziGap(16),
              ZiInput(
                label: "Secure Answer",
                variant: ZiInputVariant.stacked,
                controller: controller.secAnswerCtrl,
                  onChanged: (_) => setState(() {}), // ✅ ADD

              ),
            ],

            ziGap(16),

           ZiButtonB(
  expand: true,
  label: controller.isLoading ? "Updating..." : "Update Password",
  action: controller.isValid
      ? () async {
          setState(() {}); // refresh for loading

          final success = await controller.onSubmit();

          setState(() {}); // stop loading

          if (success) {
            ZiLogger.log("Navigate to Login ✅");

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false,
            );
          }
        }
      : null,
),
          ],
        ),
      ),
    );
  }
}
