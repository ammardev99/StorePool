import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = LoginController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body: ListView(
        shrinkWrap: true,
        children: [
          ziGap(40),

          Image.asset(
            ShellImages.logo,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),

          ziGap(10),

          heroSectionContent(
            title: ShellData.login.title,
            content: ShellData.login.info,
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

                ziGap(16),

                ZiInput(
                  label: "Password",
                  variant: ZiInputVariant.stacked,
                  type: ZiInputType.password,
                  controller: controller.passwordCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                ziGap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ZiButtonB(
                      label: "Forgot Password!",
                      variant: ZiButtonVariantB.inLine,
                      action: () {
                        ZiLogger.log("Navigate to Forgot Password");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotView(),
                          ),
                        );
                      },
                      style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
                    ),
                  ],
                ),

                ziGap(10),

                ZiButtonB(
                  label: controller.isLoading ? "Logging in..." : "Login",
                  expand: true,
                  action:
                      controller.isValid
                          ? () async {
                            await controller.onLogin();
                            setState(() {});
                          }
                          : null,
                ),
              ],
            ),
          ),

          ziGap(20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              ZiButtonB(
                label: "Create Account",
                variant: ZiButtonVariantB.inLine,
                action: () {
                  ZiLogger.log("Navigate to Signup");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupView()),
                  );
                },
                style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
