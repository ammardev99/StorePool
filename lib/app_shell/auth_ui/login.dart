import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
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
                  controller: emailCtrl,
                ),
                ziGap(16),
                ZiInput(
                  label: "Password",
                  variant: ZiInputVariant.stacked,
                  type: ZiInputType.password,
                  controller: passwordCtrl,
                ),
                ziGap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ZiButtonB(
                      label: "Forgot Password!",
                      variant: ZiButtonVariantB.inLine,
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotView()),
                        );
                      },
                      style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
                    ),
                  ],
                ),
                ziGap(10),

                ziGap(6),
                ZiButtonB(
                  label: "Login",
                  expand: true,
                  action: () {
                    // TODO: Implement login action
                  },
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
                  // TODO: Navigate to SignupView
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupView()),
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
