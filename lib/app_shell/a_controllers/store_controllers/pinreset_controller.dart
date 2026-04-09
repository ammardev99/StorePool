import 'package:flutter/material.dart';
import 'package:storepool/firebase_services/store/store_service.dart';

class PinResetController {
  final currentPinCtrl = TextEditingController();
  final newPinCtrl = TextEditingController();

  final _service = StoreService();

  String? storeId;
  bool isPinCurrentlyEnabled = false;
  bool isStorePinActive = false;

  bool isLoading = false;

  void dispose() {
    currentPinCtrl.dispose();
    newPinCtrl.dispose();
  }

  Future<void> loadPinState(String storeIdParam) async {
    final doc = await _service.getStore(storeIdParam);
    if (doc == null) return;

    final metadata = (doc.data() as Map<String, dynamic>)['metadata'] as Map<String, dynamic>;
    storeId = doc.id;
    isPinCurrentlyEnabled = metadata['isPinEnabled'] ?? false;
    isStorePinActive = isPinCurrentlyEnabled;
  }

  Future<void> handlePinAction() async {
  if (storeId == null) return;

  try {
    isLoading = true;

    // Wait a bit to ensure UI shows loading (optional)
    await Future.delayed(const Duration(milliseconds: 50));

    if (isStorePinActive) {
      await _service.setOrUpdatePin(
        storeId: storeId!,
        newPin: newPinCtrl.text.trim(),
      );
    } else {
      await _service.disablePin(storeId!);
    }
  } catch (e) {
    debugPrint("Error updating PIN: $e");
    rethrow; 
  } finally {
    isLoading = false;
  }
}
}