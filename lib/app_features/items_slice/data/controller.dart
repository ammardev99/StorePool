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
  final priceCtrl = TextEditingController();
  String? category;
  String? type;
  bool active = true;

  // Dummy options
  final categories = ['Electronics', 'Furniture', 'Clothing'];
  final types = ['Product', 'Service'];

  // State
  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  String? existingUuid;

  // Originals
  String _origName = '';
  String? _origCategory;
  String? _origType;
  bool _origActive = true;

  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;

  String get actionLabel => isEdit ? 'Update' : 'Save';

  // Validation
  bool get _canSave =>
      nameCtrl.text.trim().isNotEmpty &&
      category != null &&
      type != null &&
      priceCtrl.text.trim().isNotEmpty;

  bool get _hasChanges =>
      nameCtrl.text.trim() != _origName ||
      category != _origCategory ||
      type != _origType ||
      active != _origActive;

  void notify() => _update();

  void _update() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = _hasChanges;
  }

  // Prefill
  void prefill(dynamic data) {
    existingUuid = data.uuid;

    nameCtrl.text = data.name ?? '';
    priceCtrl.text = data.price?.toString() ?? '';
    category = data.category;
    type = data.type;
    active = data.active ?? true;

    _origName = nameCtrl.text;
    _origCategory = category;
    _origType = type;
    _origActive = active;

    _update();
  }

  // Submit
  Future<bool> submit(Future<bool> Function(String name, String category, String type,
      double price, bool active)? onSubmit) async {
    if (!formKey.currentState!.validate()) return false;

    if (onSubmit != null) {
      return await onSubmit(
        nameCtrl.text.trim(),
        category!,
        type!,
        double.tryParse(priceCtrl.text.trim()) ?? 0,
        active,
      );
    }

    return false;
  }

  // Update
  Future<bool> update(
      Future<bool> Function(String uuid, String name, String category, String type,
              double price, bool active)?
          onUpdate) async {
    if (!formKey.currentState!.validate()) return false;

    if (onUpdate != null && existingUuid != null) {
      return await onUpdate(
        existingUuid!,
        nameCtrl.text.trim(),
        category!,
        type!,
        double.tryParse(priceCtrl.text.trim()) ?? 0,
        active,
      );
    }

    return false;
  }

  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}