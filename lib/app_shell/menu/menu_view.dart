// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get user data from provider or state
    const userName = 'User';
    const userEmail = '';

    return ZiScaffoldB(
      showPagePadding: false,
      body: Column(
        children: [
          ziGap(20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ZiSvgIcon(
                          path: ShellSVGs.avPerson,
                          color: ZiColors.primary,
                          size: 80,
                        ),
                        heroSectionContent(
                          // img: ShellImages.avPerson,
                          // svgImg: ShellSVGs.avPerson,
                          title: userName,
                          content: userEmail,
                        ),
                      ],
                    ),
                  ],
                ),
                ActionTile(
                  title: "Free Plan",
                  actionLabel: "Upgrade",
                  onActionTap: () => UpgradeDialog.show(context),
                ),
              ],
            ),
          ),
          ziGap(10),
          Divider(height: 2, color: ZiColors.border),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                buildGroupedMenu(context, showGroupTitle: false),
                ZiMenuTile1(
                  icon: Icons.power_settings_new_rounded,
                  iconPrefixColor: Colors.red,
                  label: "Logout",
                  action: ZiTapAction(
                    type: ZiTapActionType.custom,
                    onTap: () async {
                      // TODO: Implement logout action
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
