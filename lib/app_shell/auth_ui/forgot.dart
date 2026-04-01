import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: ""),
      body: ListView(
        children: [
          ziGap(10),
          ZiSvgIcon(
            path: ShellSVGs.avSecure,
            color: ZiColors.primary,
            size: 80,
          ),
          heroSectionContent(
            title: ShellData.forgotPassword.title,
            content: ShellData.forgotPassword.info,
          ),
          ziGap(10),

          // ── Email + Phone ──────────────────────────────────────────
          Form(
            child: Column(
              children: [
                ZiInput(
                  label: "Email",
                  variant: ZiInputVariant.stacked,
                  controller: emailCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                ziGap(16),
                ZiInput(
                  label: "Phone Number",
                  variant: ZiInputVariant.stacked,
                  controller: phoneCtrl,
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),

          ziGap(20),

          // ── action button ──────────────────────────────────────────────────
          ZiButtonB(expand: true, label: "Continue", action: () {}),
        ],
      ),
    );
  }
}
