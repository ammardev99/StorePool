import 'package:flutter/material.dart';

class POSSliceController {
  POSSliceController();

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  /// ================= FIELDS =================

  final nameCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final rateCtrl = TextEditingController();

  /// ================= STATE =================

  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  /// ================= CHANGE HANDLER =================

  void onChange() {
    hasChangesNotifier.value = true;

    /// SIMPLE VALIDATION (UI LEVEL ONLY)
    final canSave = nameCtrl.text.isNotEmpty &&
        qtyCtrl.text.isNotEmpty &&
        rateCtrl.text.isNotEmpty;

    canSaveNotifier.value = canSave;
  }

  /// ================= NOTIFY =================

  void notify() {
    onChange();
  }

  /// ================= DISPOSE =================

  void dispose() {
    nameCtrl.dispose();
    qtyCtrl.dispose();
    rateCtrl.dispose();

    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}