import 'package:flutter/material.dart';
import 'package:storepool/app_features/view_io.dart';
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

  void showSnack(String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
            isTitle: true,
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
                  label: "Login",
                  expand: true,
                  loading: controller.isLoading,
                  action: controller.isValid
                      ? () async {
                          setState(() => controller.isLoading = true);

                          final result = await controller.onLogin();

                          setState(() => controller.isLoading = false);

                          if (result) {
                            showSnack("Login Successful ", success: true);
                            ZiLogger.log("Navigate to Dashboard ");

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StorePoolAppView(),
                              ),
                              (route) => false,
                            );
                          } else {
                            showSnack("Login Failed ", success: false);
                            ZiLogger.log("Login Failed ");
                          }
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