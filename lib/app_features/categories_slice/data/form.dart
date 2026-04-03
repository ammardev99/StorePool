// ─── Zi_Slice: Form ───────────────────────────────────────────────────────────
// ROLE: Inputs + save button only. Owned by controller. No navigation logic.
// RULE: All fields must have enabled: !ctrl.isView
// RULE: All fields must call _onChange() in onChanged
// RULE: Non-text fields must call ctrl.notify() directly
// RULE: Save button uses ValueListenableBuilder(ctrl.canSaveNotifier)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

import '../a_categories_slice_io.dart';

class CategoriesSliceForm extends StatefulWidget with ZiFormMixin {
  final CategoriesSliceController ctrl;

  final Future<bool> Function(String name, String type, int sort, bool active)? onSubmit;
  final Future<bool> Function(String uuid, String name, String type, int sort, bool active)? onUpdate;

  const CategoriesSliceForm(
    this.ctrl, {
    super.key,
    this.onSubmit,
    this.onUpdate,
  });

  @override
  ValueNotifier<bool> get hasChanges => ctrl.hasChangesNotifier;

  @override
  ZiFormMode get mode => ctrl.formMode;

  @override
  VoidCallback? get onClose => ctrl.dispose;

  @override
  State<CategoriesSliceForm> createState() => _CategoriesSliceFormState();
}

class _CategoriesSliceFormState extends State<CategoriesSliceForm> {
  CategoriesSliceController get ctrl => widget.ctrl;

  void _onChange() {
    setState(() {});
    ctrl.notify();
  }

  Future<void> _onAction() async {
    final ok = ctrl.isEdit
        ? await ctrl.update(widget.onUpdate)
        : await ctrl.submit(widget.onSubmit);

    if (!mounted) return;
    if (ok) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctrl.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          ZiInput(
            label: 'Category Title',
            controller: ctrl.nameCtrl,
            enabled: !ctrl.isView,
            onChanged: (_) => _onChange(),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),

          ziGap(16),

          // Type using ZiSelectB
          ZiSelectB<String>(
            label: 'Type',
            items: const ['product', 'service'],
            value: ctrl.type,
            itemLabel: (e) => e == 'product' ? 'Product' : 'Service',
            enabled: !ctrl.isView,
            onChanged: (val) {
              ctrl.type = val ?? 'product';
              _onChange();
            },
          ),

          ziGap(16),

          // Sort Order
          ZiInput(
            label: 'Sort Order',
            controller: ctrl.sortCtrl,
            enabled: !ctrl.isView,
            // keyboardType: TextInputType.number,
            onChanged: (_) => _onChange(),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (int.tryParse(v) == null) return 'Enter a number';
              return null;
            },
          ),

          ziGap(16),

          // Active Toggle
          ZiSwitch(
            // label: 'Active',
            value: ctrl.isActive,
            
            

            // enabled: !ctrl.isView,
            onChanged: (val) {
              ctrl.isActive = val;
              _onChange();
            },
          ),

          ziGap(24),

          // Save Button
          if (!ctrl.isView)
            ValueListenableBuilder<bool>(
              valueListenable: ctrl.canSaveNotifier,
              builder: (_, canSave, __) => ZiButtonB(
                expand: true,
                label: ctrl.actionLabel,
                disabled: !canSave,
                action: _onAction,
              ),
            ),
        ],
      ),
    );
  }
}