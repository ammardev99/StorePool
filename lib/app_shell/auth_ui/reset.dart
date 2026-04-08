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
              isTitle: true,
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

            // Row(
            //   children: [
            //     ZiCheckbox(
            //       value: controller.isUpdateSecurityQA,
            //       onChanged: (value) {
            //         controller.toggleSecurityQA(value);
            //         setState(() {});
            //       },
            //     ),
            //     ziGap(10),
            //     const Text("Update security question!"),
            //   ],
            // ),

            // if (controller.isUpdateSecurityQA) ...[
            //   ziGap(16),
            //   ZiInput(
            //     label: "Security Question",
            //     variant: ZiInputVariant.stacked,
            //     controller: controller.secQuestionCtrl,
            //       onChanged: (_) => setState(() {}), // ✅ ADD

            //   ),
            //   ziGap(16),
            //   ZiInput(
            //     label: "Secure Answer",
            //     variant: ZiInputVariant.stacked,
            //     controller: controller.secAnswerCtrl,
            //       onChanged: (_) => setState(() {}),

            //   ),
            // ],

            // ziGap(16),
ziGap(10),

if (controller.newPassCtrl.text.isNotEmpty ||
    controller.confirmPassCtrl.text.isNotEmpty)
  Row(
    children: [
      Icon(
        controller.isPasswordMatch ? Icons.check_circle : Icons.cancel,
        color: controller.isPasswordMatch ? Colors.green : Colors.red,
        size: 18,
      ),
      ziGap(8),
      if(!controller.isPasswordMatch)
      Text(
            "New and Confirm Passwords must be same",
        style: TextStyle(
          color: controller.isPasswordMatch
              ? Colors.green
              : Colors.red,
          fontSize: 13,
        ),
      ),
    ],
  ),

ziGap(16),
           ZiButtonB(
  expand: true,
  label:  "Update Password",
  loading: controller.isLoading,
  action: controller.isValid
    ? () async {
        setState(() {}); 

        final success = await controller.onSubmit();

        setState(() {});

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password updated successfully ✅"),
              backgroundColor: Colors.green,
               behavior: SnackBarBehavior.floating,
               
    
            ),
          );

          ZiLogger.log("Navigate to Login ");

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (route) => false,
          );
        } else {
          // ❌ ERROR SNACKBAR
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Old Password not match"),
              backgroundColor: Colors.red,
            ),
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
