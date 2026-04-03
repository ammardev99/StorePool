// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

import '../app_shell_io.dart';

enum MenuGroup { userAccount, settings, support, other, appShell, store }

// Menu Model
class MenuModel {
  final IconData prefix;
  final String label;
  final MenuGroup group;
  // final MenuState state;
  final ZiTapAction action;

  const MenuModel({
    required this.prefix,
    required this.label,
    required this.group,
    // this.state = MenuState.enabled,
    required this.action,
  });
}

// Menu List
final List<MenuModel> menuList = [
  // --------------User Account--------------//
  // MenuModel(
  //   prefix: Icons.store_mall_directory_rounded,
  //   label: 'Store Settings',
  //   group: MenuGroup.userAccount,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: StoreMenuView()),
  // ),
  // // Edit Profile
  // MenuModel(
  //   prefix: Icons.person_outline_rounded,
  //   label: 'Edit Profile',
  //   group: MenuGroup.userAccount,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: EditProfileView(),
  //   ),
  // ),
  // Reset Password
  MenuModel(
    prefix: Icons.password_outlined,
    label: 'Reset Password',
    group: MenuGroup.userAccount,
    action: ZiTapAction(
      type: ZiTapActionType.openPage,
      page: ResetPasswordView(),
    ),
  ),

  // // Contact Us
  // MenuModel(
  //   prefix: Icons.settings_outlined,
  //   label: 'Contact Us',
  //   group: MenuGroup.userAccount,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: ContactUsView()),
  // ),
  // Contact Us on whatsapp
  // MenuModel(
  //   prefix: Icons.forum_outlined,
  //   label: 'Contact Us',
  //   group: MenuGroup.userAccount,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: ContactUsView()),
  // ),

  // MenuModel(
  //   prefix: Icons.bug_report_outlined,
  //   label: 'Report a Bug',
  //   group: MenuGroup.settings,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: ReportBugView()),
  // ),
  // MenuModel(
  //   prefix: Icons.help_outline_rounded,
  //   label: 'FAQs Help',
  //   group: MenuGroup.settings,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: FAQsView()),
  // ),
  // MenuModel(
  //   prefix: Icons.dark_mode_outlined,
  //   label: 'Dark Mode',
  //   group: MenuGroup.settings,
  //   action: ZiTapAction(type: ZiTapActionType.custom),
  // ),

  MenuModel(
    prefix: Icons.warning,
    label: 'sand box',
    group: MenuGroup.support,
    action: ZiTapAction(type: ZiTapActionType.openPage, page: TestShell()),
  ),

  // --------------App Shell--------------//
  // About App
  MenuModel(
    prefix: Icons.info_outlined,
    label: 'About App',
    group: MenuGroup.appShell,
    action: ZiTapAction(type: ZiTapActionType.openPage, page: AboutPageView()),
  ),
  // Privacy Policy
  MenuModel(
    prefix: Icons.privacy_tip_outlined,
    label: 'Privacy Policy',
    group: MenuGroup.appShell,
    action: ZiTapAction(
      type: ZiTapActionType.openPage,
      page: PrivacyPolicyPage(),
    ),
  ),
  // T&C
  MenuModel(
    prefix: Icons.list_alt_rounded,
    label: 'Terms & Conditions',
    group: MenuGroup.appShell,
    action: ZiTapAction(
      type: ZiTapActionType.openPage,
      page: TermsConditionsPageView(),
    ),
  ),
  // Rate App
  MenuModel(
    prefix: Icons.star_rate_outlined,
    label: 'Rate App',
    group: MenuGroup.appShell,
    action: ZiTapAction(
      type: ZiTapActionType.openUrl,
      url:
          "https://play.google.com/store/apps/developer?id=samz+creation&hl=en&gl=US",
    ),
  ),
  // Share App
  // MenuModel(
  //   prefix: Icons.share_outlined,
  //   label: 'Share App',
  //   group: MenuGroup.appShell,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: TermsConditionsPage(),
  //   ),
  // ),
  // Disclaimer
  // MenuModel(
  //   prefix: Icons.cast_outlined,
  //   label: 'Disclaimer',
  //   group: MenuGroup.appShell,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: DisclaimerPage()),
  // ),
  // Return & Refund Policy
  // MenuModel(
  //   prefix: Icons.reset_tv_rounded,
  //   label: 'Return & Refund Policy',
  //   group: MenuGroup.appShell,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.openPage,
  //     page: ReturnRefundPolicyPage(),
  //   ),
  // ),

  // More Apps
  MenuModel(
    prefix: Icons.category_outlined,
    label: 'More Apps',
    group: MenuGroup.appShell,
    action: ZiTapAction(
      type: ZiTapActionType.openUrl,
      url:
          'https://play.google.com/store/apps/developer?id=samz+creation&hl=en&gl=US',
    ),
  ),

  // Logout

  // if

  // MenuModel(
  //   prefix: Icons.developer_mode,
  //   label: 'Test Page',
  //   group: MenuGroup.appShell,
  //   action: ZiTapAction(type: ZiTapActionType.openPage, page: TestShell()),
  // ),
  // MenuModel(
  //   prefix: Icons.power_settings_new_rounded,
  //   label: 'Logout',
  //   group: MenuGroup.appShell,
  //   action: ZiTapAction(
  //     type: ZiTapActionType.custom, // use custom action for logout
  //     onTap: () async {
  //       AppLogger.log("User tapped Logout");

  //       // Sign out from Firebase
  //       try {
  //       await AuthService().signOut();
  //       AppLogger.log("User successfully logged out");
  //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginView(),), (route) => false,);
  //       }
  //       catch(e){
  //       }
  //     },
  //   ),
  // ),
];

// ----------------- Featch Menu -----------------//
Widget buildGroupedMenu(
  BuildContext context, {
  List<MenuGroup>? groups,
  bool showGroupTitle = true,
}) {
  final effectiveGroups = groups ?? MenuGroup.values;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        effectiveGroups.map((group) {
          final items =
              menuList
                  // .where((e) => e.group == group && e.state != MenuState.hidden)
                  .where((e) => e.group == group)
                  .toList();

          if (items.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showGroupTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, bottom: 4),
                  child: Text(
                    group.name.toUpperCase(),
                    style: ZiTypoStyles.caption,
                  ),
                ),
              ...items.map((item) {
                return ZiMenuTile1(
                  icon: item.prefix,
                  iconPrefixColor:
                      item.label == "Logout" ? Colors.red : Colors.grey,
                  label: item.label,
                  action: item.action,
                  // enabled: item.state == MenuState.enabled,
                  // action:  item.state == MenuState.enabled ? item.action : null,
                );
              }),
            ],
          );
        }).toList(),
  );
}
