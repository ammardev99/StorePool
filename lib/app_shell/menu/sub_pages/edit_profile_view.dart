import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_shell_io.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final controller = EditProfileController();

 @override
void initState() {
  super.initState();
  _loadUserData();
}

Future<void> _loadUserData() async {
  final userData = await AuthService().getUserData();
  if (userData != null) {
    controller.init(
      name: userData['name'] ?? '',
      phone: userData['phone'] ?? '',
      email: userData['email'] ?? '',
    );
    setState(() {}); // refresh UI after loading
  }
}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: "Edit Profile"),
      body: Form(
        child: ListView(
          children: [
            ZiSvgIcon(
              path: ShellSVGs.avPerson,
              color: ZiColors.primary,
              size: 80,
            ),

            heroSectionContent(
              title: ShellData.editProfile.title,
              isTitle: true,
              content: ShellData.editProfile.info,
            ),

            ziGap(20),

            ZiInput(
              label: "Full Name",
              controller: controller.nameCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),

            ziGap(16),

            ZiInput(
              label: "Phone Number",
              controller: controller.phoneCtrl,
              variant: ZiInputVariant.stacked,
              onChanged: (_) => setState(() {}),
            ),

            ziGap(16),

            ZiInput(
              label: "Email",
              controller: controller.emailCtrl,
              variant: ZiInputVariant.stacked,
              enabled: false,
            ),

            ziGap(20),

          ZiButtonB(
  expand: true,
  label: "Update Profile",
  loading: controller.isLoading,
  action: controller.isValid
      ? () async {
          final success = await controller.onUpdate(); // now returns bool
          setState(() {}); // refresh UI/loading
          if (success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MenuView()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update profile")),
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
