import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_features/view_io.dart';
import '../app_shell_io.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
   late final SignupController controller;

  @override
  void initState() {
    super.initState();
    controller = SignupController();
    ZiLogger.log("SignupView: Controller Created ✅");
  }

  @override
  void dispose() {
    controller.dispose();
    ZiLogger.log("SignupView: Controller Disposed 🗑️");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: ""),
      body: ListView(
        shrinkWrap: true,
        children: [
          ZiSvgIcon(
            path: ShellSVGs.avPerson,
            color: ZiColors.primary,
            size: 80,
          ),

          heroSectionContent(
            title: ShellData.register.title,
            isTitle: true,
            content: ShellData.register.info,
          ),

          ziGap(10),

          Form(
            child: Column(
              children: [
                ZiInput(
                  label: "Full Name",
                  variant: ZiInputVariant.stacked,
                  controller: controller.nameCtrl,
                  onChanged: (_) => setState(() {}),
                ),

                ziGap(10),

                ZiInput(
                  label: "Phone Number",
                  variant: ZiInputVariant.stacked,
                  controller: controller.phoneCtrl,
                  onChanged: (_) => setState(() {}),
                ),

                ziGap(16),

                ZiInput(
                  label: "Email",
                  variant: ZiInputVariant.stacked,
                  controller: controller.emailCtrl,
                  onChanged: (_) => setState(() {}),
                ),

                ziGap(16),

                ZiInput(
                  label: "Password",
                  variant: ZiInputVariant.stacked,
                  type: ZiInputType.password,
                  controller: controller.passwordCtrl,
                  onChanged: (_) => setState(() {}),
                ),

                ziGap(16),

                // ZiInput(
                //   label: "Security Question",
                //   variant: ZiInputVariant.stacked,
                //   controller: controller.secQCtrl,
                // ),

                // ziGap(10),

                // ZiInput(
                //   label: "Security Answer",
                //   variant: ZiInputVariant.stacked,
                //   controller: controller.secACtrl,
                // ),

                // ziGap(16),

                Row(
                  children: [
                    ZiCheckbox(
                      value: controller.agreedToTerms,
                      onChanged: (v) {
                        controller.toggleTerms(v);
                        setState(() {});
                      },
                    ),
                    ziGap(10),
                    const Text("Agree with"),
                    ziGap(3),
                    ZiButtonB(
                      label: "Terms & Conditions!",
                      variant: ZiButtonVariantB.inLine,
                      style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
                      action: () {
                        ZiLogger.log("Navigate to Terms");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const TermsConditionsPageView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ziGap(10),
                Row(
                  children: [
                    ZiCheckbox(
                      value: controller.rememberMe,
                      onChanged: (v) {
                        setState(() {
                          controller.rememberMe = v;
                        });
                      },
                    ),
                    ziGap(10),
                    const Text("Remember Me"),
                  ],
                ),
                ziGap(10),

                ziGap(10),

               ZiButtonB(
  label:  "Signup",
  expand: true,
  loading: controller.isLoading,
 action: () async {
  setState(() => controller.isLoading = true); // start loading

  final success = await controller.onSignup();

  if (!mounted) return;

  setState(() => controller.isLoading = false); // stop loading

  if (success) {
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => StorePoolAppView()),
    );
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signup failed. Check console for details.")),
    );
  }
},
),
              ],
            ),
          ),

          ziGap(20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              ZiButtonB(
                label: "Sign In",
                variant: ZiButtonVariantB.inLine,
                action: () {
                  ZiLogger.log("Navigate to Login");

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
              ),
            ],
          ),

          ziGap(20),
        ],
      ),
    );
  }
}
