// ─── Zi_Slice: Form ───────────────────────────────────────────────────────────
// ROLE: Inputs + save button only. Owned by controller. No navigation logic.
// RULE: All fields must have enabled: !ctrl.isView
// RULE: All fields must call _onChange() in onChanged
// RULE: Non-text fields must call ctrl.notify() directly
// RULE: Save button uses ValueListenableBuilder(ctrl.canSaveNotifier)
// RENAME: XxxSliceForm → YourFeatureForm
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

import '../a_items_slice_io.dart';

class ItemsSliceForm extends StatefulWidget with ZiFormMixin {
  final ItemsSliceController ctrl;

  final Future<bool> Function(String name, String category, String type,
      double price, bool active)? onSubmit;
  final Future<bool> Function(String uuid, String name, String category,
      String type, double price, bool active)? onUpdate;

  const ItemsSliceForm(
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
  State<ItemsSliceForm> createState() => _ItemsSliceFormState();
}

class _ItemsSliceFormState extends State<ItemsSliceForm> {
  ItemsSliceController get ctrl => widget.ctrl;

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
        children: [
          ZiInput(
            label: 'Item Title',
            controller: ctrl.nameCtrl,
            enabled: !ctrl.isView,
            onChanged: (_) => _onChange(),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          ziGap(10),
 ZiInput(
            label: 'Price',
            controller: ctrl.priceCtrl,
            // keyboardType: TextInputType.number,
            enabled: !ctrl.isView,
            onChanged: (_) => _onChange(),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          ziGap(10),
          ZiSelectB<String>(
            label: 'Category',
            items: ctrl.categories,
            value: ctrl.category,
            itemLabel: (c) => c,
            enabled: !ctrl.isView,
            onChanged: (v) {
              ctrl.category = v;
              ctrl.notify();
            },
          ),
          ziGap(10),

          ZiSelectB<String>(
            label: 'Type',
            items: ctrl.types,
            value: ctrl.type,
            itemLabel: (t) => t,
            enabled: !ctrl.isView,
            onChanged: (v) {
              ctrl.type = v;
              ctrl.notify();
            },
          ),
          ziGap(10),

         
          ZiSwitch(
            // label: 'Active',
            value: ctrl.active,
            onChanged: (v) {
              ctrl.active = v;
              ctrl.notify();
            },
          ),

          // ZiToggleB(
          //   label: 'Available',
          //   value: ctrl.active,
          //   enabled: !ctrl.isView,
          //   onChanged: (v) {
          //     ctrl.active = v;
          //     ctrl.notify();
          //   },
          // ),
          ziGap(20),

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