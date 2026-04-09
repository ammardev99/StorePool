import 'package:flutter/material.dart';
import 'package:storepool/app_shell/a_controllers/store_controllers/pinreset_controller.dart';
import 'package:storepool/app_shell/shell_utils/images.dart';
import 'package:zi_core/zi_core_io.dart';

class PinResetStoreView extends StatefulWidget {
  final String? storeId; // pass actual storeId if needed
  const PinResetStoreView({super.key, this.storeId});

  @override
  State<PinResetStoreView> createState() => _ResetStorePINState();
}

class _ResetStorePINState extends State<PinResetStoreView> {
  final controller = PinResetController();
  String storeId = ""; 

  @override
  void initState() {
    super.initState();
    controller.loadPinState(storeId).then((_) => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      appBar: ZiAppBarB(title: ""),
      body: ListView(
        children: [
          ZiSvgIcon(path: ShellSVGs.avSecure, color: ZiColors.primary, size: 80),
          heroSectionContent(title: "Reset Store PIN", content: "Keep your PIN updated."),
          ziGap(10),
          ZiSwitchB(
            value: controller.isStorePinActive,
            onChanged: (value) => setState(() => controller.isStorePinActive = value),
            label: "Secure My Store via PIN",
          ),
          ziGap(10),
          if (controller.isStorePinActive) ...[
            if (controller.isPinCurrentlyEnabled)
              ZiInput(
                label: "Current PIN",
                type: ZiInputType.password,
                controller: controller.currentPinCtrl,
              ),
            ziGap(16),
            ZiInput(
              label: "New PIN",
              type: ZiInputType.password,
              controller: controller.newPinCtrl,
            ),
            ziGap(16),
           ZiButtonB(
  expand: true,
  label: controller.isPinCurrentlyEnabled ? "Update Store PIN" : "Set Store PIN",
  loading: controller.isLoading,
  action: () async {
    setState(() {}); // start loading
    try {
      await controller.handlePinAction();

      // Success
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Store PIN updated successfully!" ,), backgroundColor: Colors.green),
      );
      Navigator.pop(context); // pop after success
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update PIN: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {}); // stop loading
    }
  },
),
          ],
        ],
      ),
    );
  }
}