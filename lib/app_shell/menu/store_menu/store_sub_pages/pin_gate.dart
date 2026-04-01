import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../../app_shell_io.dart';

class PINGateView extends StatefulWidget {
  const PINGateView({super.key});

  @override
  State<PINGateView> createState() => _PINGateViewState();
}

class _PINGateViewState extends State<PINGateView> {
  final _pinCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get user and store data from providers
    const storeName = 'No Store';
    const storeCategory = 'Create a store to get started';
    const userName = 'User';
    const userEmail = '';

    return ZiScaffoldB(
      body: ListView(
        shrinkWrap: true,
        children: [
          ziGap(40),
          ZiSvgIcon(path: ShellSVGs.avShop, color: ZiColors.primary, size: 80),

          heroSectionContent(
            isTitle: true,
            // img: ShellImages.avShop,
            title: storeName,
            content: storeCategory,
          ),
          ziGap(10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                ziGap(16),
                ZiInput(
                  label: 'Store PIN',
                  variant: ZiInputVariant.stacked,
                  controller: _pinCtrl,
                  validator: (v) => v!.isEmpty ? 'PIN required' : null,
                  type: ZiInputType.password,
                ),
                ziGap(16),
                ZiButtonB(
                  label: 'Continue',
                  expand: true,
                  action: () {
                    // TODO: Implement PIN validation and navigation
                  },
                ),
                ziGap(10),
              ],
            ),
          ),

          ziGap(20),
          // ── store info card ───────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: ZiColors.border,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Icon(Icons.person),
              title: Text(userName, style: ZiTypoStyles.titleMd),
              subtitle: Text(userEmail),
              trailing: ZiButtonB(
                label: 'Log Out',
                variant: ZiButtonVariantB.chip,
                action: () {
                  // TODO: Implement logout action
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
