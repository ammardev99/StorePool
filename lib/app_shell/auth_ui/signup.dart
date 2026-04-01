import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_view/view_io.dart';
import '../app_shell_io.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController secQCtrl = TextEditingController();
  final TextEditingController secACtrl = TextEditingController();
  bool agreedToTerms = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    secQCtrl.dispose();
    secACtrl.dispose();
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
            content: ShellData.register.info,
          ),
          ziGap(10),
          Form(
            child: Column(
              children: [
                ZiInput(
                  label: "Full Name",
                  variant: ZiInputVariant.stacked,
                  controller: nameCtrl,
                ),
                ziGap(10),
                ZiInput(
                  label: "Phone Number",
                  variant: ZiInputVariant.stacked,
                  controller: phoneCtrl,
                ),
                ziGap(16),
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
                ziGap(16),
                ZiInput(
                  label: "Security Question",
                  variant: ZiInputVariant.stacked,
                  controller: secQCtrl,
                ),
                ziGap(10),
                ZiInput(
                  label: "Security Answer",
                  variant: ZiInputVariant.stacked,
                  controller: secACtrl,
                ),
                ziGap(16),
                Row(
                  children: [
                    ZiCheckbox(
                      value: agreedToTerms,
                      onChanged: (v) => setState(() => agreedToTerms = v),
                    ),
                    ziGap(10),
                    const Text("Agree with"),
                    ziGap(3),
                    ZiButtonB(
                      label: "Terms & Conditions!",
                      variant: ZiButtonVariantB.inLine,
                      style: ZiButtonStyleB(foregroundColor: ZiColors.primary),
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsConditionsPageView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ziGap(10),

                ziGap(10),
                ZiButtonB(
                  label: "Signup",
                  expand: true,
                  action: () {
                    // TODO: Implement signup action
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NameAppView()),
                    );
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
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
