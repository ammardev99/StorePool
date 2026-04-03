// ─── Zi_Slice: Controller ─────────────────────────────────────────────────────
// ROLE: Form state only. Validation, notifiers, submit, update, dispose.
// RULE: Never access BuildContext. Never navigate. Never show dialogs.
// RULE: notify() must be called on every field change.
// RULE: prefill() must snapshot originals at the end then call notify().
// RENAME: XxxSliceController → YourFeatureController
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class CategoriesSliceController {
  ZiFormMode formMode;

  CategoriesSliceController({this.formMode = ZiFormMode.add}) {
    _update();
  }

  final formKey = GlobalKey<FormState>();

  // Fields
  final nameCtrl = TextEditingController();
  String type = 'product'; // default value
  final sortCtrl = TextEditingController();
  bool isActive = true;

  // State
  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  String? existingUuid;

  // Originals
  String _origName = '';
  String _origType = '';
  String _origSort = '';
  bool _origActive = true;

  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;

  String get actionLabel => isEdit ? 'Update' : 'Save';

  // Validation
  bool get _canSave =>
      nameCtrl.text.trim().isNotEmpty &&
      (isAdd ? true : _hasChanges);

  bool get _hasChanges =>
      nameCtrl.text.trim() != _origName ||
      type != _origType ||
      sortCtrl.text.trim() != _origSort ||
      isActive != _origActive;

  void notify() => _update();

  void _update() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = _hasChanges;
  }

  // Prefill
  void prefill(dynamic data) {
    existingUuid = data.uuid;

    nameCtrl.text = data.name ?? '';
    type = data.type ?? 'product';
    sortCtrl.text = data.sortOrder?.toString() ?? '';
    isActive = data.isActive ?? true;

    _origName = nameCtrl.text;
    _origType = type;
    _origSort = sortCtrl.text;
    _origActive = isActive;

    _update();
  }

  // Submit
  Future<bool> submit(Future<bool> Function(String name, String type, int sort, bool active)? onSubmit) async {
    if (!formKey.currentState!.validate()) return false;
    final sortValue = int.tryParse(sortCtrl.text.trim()) ?? 0;

    if (onSubmit != null) {
      return await onSubmit(nameCtrl.text.trim(), type, sortValue, isActive);
    }

    return false;
  }

  // Update
  Future<bool> update(Future<bool> Function(String uuid, String name, String type, int sort, bool active)? onUpdate) async {
    if (!formKey.currentState!.validate()) return false;
    final sortValue = int.tryParse(sortCtrl.text.trim()) ?? 0;

    if (onUpdate != null && existingUuid != null) {
      return await onUpdate(existingUuid!, nameCtrl.text.trim(), type, sortValue, isActive);
    }

    return false;
  }

  void dispose() {
    nameCtrl.dispose();
    sortCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}