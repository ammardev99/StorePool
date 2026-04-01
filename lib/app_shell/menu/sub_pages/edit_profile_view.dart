import 'package:flutter/material.dart';
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

    // 🔥 Replace with real user data (from API / local storage)
    controller.init(
      name: "Ammar",
      phone: "03001234567",
      email: "ammar@gmail.com",
    );
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
              label: controller.isLoading ? "Updating..." : "Update Profile",
              action:
                  controller.isValid
                      ? () async {
                        await controller.onUpdate();
                        setState(() {});
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
