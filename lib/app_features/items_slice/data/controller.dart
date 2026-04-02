// ─── Zi_Slice: Controller ─────────────────────────────────────────────────────
// ROLE: Form state only. Validation, notifiers, submit, update, dispose.
// RULE: Never access BuildContext. Never navigate. Never show dialogs.
// RULE: notify() must be called on every field change.
// RULE: prefill() must snapshot originals at the end then call notify().
// RENAME: XxxSliceController → YourFeatureController
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ItemsSliceController {
  ZiFormMode formMode;

  ItemsSliceController({this.formMode = ZiFormMode.add}) {
    _update();
  }

  final formKey = GlobalKey<FormState>();

  // Fields
  final nameCtrl = TextEditingController();

  // State
  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  String? existingUuid;

  // Originals
  String _origName = '';

  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;

  String get actionLabel => isEdit ? 'Update' : 'Save';

  // Validation
  bool get _canSave => isAdd ? nameCtrl.text.trim().isNotEmpty : _hasChanges;

  bool get _hasChanges => nameCtrl.text.trim() != _origName;

  void notify() => _update();

  void _update() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = _hasChanges;
  }

  // Prefill
  void prefill(dynamic data) {
    existingUuid = data.uuid;

    nameCtrl.text = data.name ?? '';
    _origName = nameCtrl.text;

    _update();
  }

  // Submit
  Future<bool> submit(Future<bool> Function(String name)? onSubmit) async {
    if (!formKey.currentState!.validate()) return false;

    if (onSubmit != null) {
      return await onSubmit(nameCtrl.text.trim());
    }

    return false;
  }

  // Update
  Future<bool> update(
    Future<bool> Function(String uuid, String name)? onUpdate,
  ) async {
    if (!formKey.currentState!.validate()) return false;

    if (onUpdate != null && existingUuid != null) {
      return await onUpdate(existingUuid!, nameCtrl.text.trim());
    }

    return false;
  }

  void dispose() {
    nameCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}
