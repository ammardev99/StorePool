import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import '../../../app_shell_io.dart';

class PinResetStoreView extends StatefulWidget {
  const PinResetStoreView({super.key});

  @override
  State<PinResetStoreView> createState() => _ResetStorePINState();
}

class _ResetStorePINState extends State<PinResetStoreView> {
  final TextEditingController currentPinCtrl = TextEditingController();
  final TextEditingController newPinCtrl = TextEditingController();
  bool isStorePinActive = false;
  bool isPinCurrentlyEnabled = false; // TODO: Get from backend

  @override
  void dispose() {
    currentPinCtrl.dispose();
    newPinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: ""),
      body: ListView(
        children: [
          ZiSvgIcon(
            path: ShellSVGs.avSecure,
            color: ZiColors.primary,
            size: 80,
          ),

          heroSectionContent(
            title: "Reset Store PIN",
            content: "Keep your PIN updated.",
          ),
          ziGap(10),
          ZiSwitchB(
            value: isStorePinActive,
            onChanged: (value) {
              // TODO: Implement toggle PIN action
              setState(() => isStorePinActive = value);
            },
            label: "Secure My Store via PIN",
          ),
          ziGap(10),
          if (isStorePinActive) ...[
            // only show current PIN field if PIN was already set
            if (isPinCurrentlyEnabled) ...[
              ZiInput(
                label: "Current PIN",
                variant: ZiInputVariant.stacked,
                type: ZiInputType.password,
                controller: currentPinCtrl,
                onChanged: (_) => setState(() {}),
              ),
              ziGap(16),
            ],
            ZiInput(
              label: "New PIN",
              variant: ZiInputVariant.stacked,
              type: ZiInputType.password,
              controller: newPinCtrl,
              onChanged: (_) => setState(() {}),
            ),
            ziGap(16),
            ZiButtonB(
              expand: true,
              label:
                  isPinCurrentlyEnabled ? "Update Store PIN" : "Set Store PIN",
              action: () {
                // TODO: Implement update PIN action
              },
            ),
          ],
        ],
      ),
    );
  }
}
