// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:zi_core/zi_core_io.dart';
// import '../app_shell_io.dart';

// class MenuView extends StatelessWidget {
//   const MenuView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // DO: Get user data from provider or state
//     const userName = 'User';
//     const userEmail = '';

//     return ZiScaffoldB(
//       showPagePadding: false,
//       body: Column(
//         children: [
//           ziGap(20),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         ZiSvgIcon(
//                           path: ShellSVGs.avPerson,
//                           color: ZiColors.primary,
//                           size: 80,
//                         ),
//                         heroSectionContent(
//                           // img: ShellImages.avPerson,
//                           // svgImg: ShellSVGs.avPerson,
//                           title: userName,
//                           content: userEmail,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 ActionTile(
//                   title: "Free Plan",
//                   actionLabel: "Upgrade",
//                   onActionTap: () => UpgradeDialog.show(context),
//                 ),
//               ],
//             ),
//           ),
//           ziGap(10),
//           Divider(height: 2, color: ZiColors.border),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(0),
//               children: [
//                 buildGroupedMenu(context, showGroupTitle: false),
//                 ZiMenuTile1(
//                   icon: Icons.power_settings_new_rounded,
//                   iconPrefixColor: Colors.red,
//                   label: "Logout",
//                   action: ZiTapAction(
//                     type: ZiTapActionType.custom,
//                     onTap: () async {
//                       // DO: Implement logout action
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';
import '../app_shell_io.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final AuthService _authService = AuthService();

  String userName = 'User';
  String userEmail = '';
  String userRole = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await _authService.getUserData();
    if (data != null) {
      setState(() {
        userName = data['name'] ?? 'User';
        userEmail = data['email'] ?? '';
        userRole = data['role'] ?? '';
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      showPagePadding: false,
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
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
                                  title: userName,
                                  content: '$userEmail • $userRole',
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
                              bool? isConfirm =
                                  await ziConfirmationDialogResult(
                                    context: context,
                                    actionLabel: "Logout",
                                    colorTone: ZiColors.debugRed,
                                    icon: Icons.power_settings_new_rounded,
                                  );

                              if (isConfirm!) {
                                ZiLogger.log("Logout Button Clicked 🔴");
                                await _authService.logout();
                                ZiLogger.log("User Logged Out ✅");
                                Navigator.pushAndRemoveUntil(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ZAppGateView(),
                                  ),
                                  (route) => false,
                                );
                              }
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
