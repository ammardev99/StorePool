import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../app_shell_io.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: Prefill data from user profile
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
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
              controller: nameCtrl,
              variant: ZiInputVariant.stacked,
            ),
            ziGap(16),
            ZiInput(
              label: "Phone Number",
              controller: phoneCtrl,
              variant: ZiInputVariant.stacked,
            ),
            ziGap(16),
            ZiInput(
              label: "Email",
              controller: emailCtrl,
              variant: ZiInputVariant.stacked,
              enabled: false,
            ),
            ziGap(20),
            ZiButtonB(
              expand: true,
              label: "Update Profile",
              action: () {
                // TODO: Implement update profile action
              },
            ),
          ],
        ),
      ),
    );
  }
}
