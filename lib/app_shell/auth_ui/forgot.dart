import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final controller = ForgotController();

  @override
  void dispose() {
    controller.dispose();
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
            isTitle: true,
            content: ShellData.forgotPassword.info,
          ),

          ziGap(10),

          Form(
            child: Column(
              children: [
                ZiInput(
                  label: "Email",
                  variant: ZiInputVariant.stacked,
                  controller: controller.emailCtrl,
                  onChanged: (_) => setState(() {}),
                ),


                // ZiInput(
                //   label: "Phone Number",
                //   variant: ZiInputVariant.stacked,
                //   controller: controller.phoneCtrl,
                //   onChanged: (_) => setState(() {}),
                // ),
              ],
            ),
          ),

          ziGap(20),

          ZiButtonB(
            expand: true,
            loading: controller.isLoading,
            label: "Continue",
            action: () async {
              await controller.onSubmit();
              setState(() {}); // refresh if needed
            },
          ),
        ],
      ),
    );
  }
}
