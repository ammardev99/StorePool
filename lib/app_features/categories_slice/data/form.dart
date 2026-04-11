import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';
import 'controller.dart';

class CategoryForm extends StatefulWidget with ZiFormMixin {
  final CategoryController ctrl;

  const CategoryForm(this.ctrl, {super.key});

  @override
  ValueNotifier<bool> get hasChanges => ctrl.hasChangesNotifier;

  @override
  ZiFormMode get mode => ctrl.formMode;

  @override
  VoidCallback? get onClose => ctrl.dispose;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  CategoryController get ctrl => widget.ctrl;

  void _onChange() {
    setState(() {});
    ctrl.notify();
  }

  Future<void> _onAction() async {
    final ok = ctrl.isEdit
        ? await ctrl.update(ctrl.origUuid)
        : await ctrl.submit();

    if (!mounted) return;
    if (ok) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctrl.formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ZiInput(
            label: 'Category Name *',
            variant: ZiInputVariant.stacked,
            controller: ctrl.nameCtrl,
            enabled: !ctrl.isView,
            onChanged: (_) => _onChange(),
            validator: (v) => v == null || v.isEmpty ? 'Name required' : null,
          ),
          ziGap(16),

          if (!ctrl.isView)
            ValueListenableBuilder<bool>(
              valueListenable: ctrl.canSaveNotifier,
              builder: (_, canSave, __) {
                final msg = !canSave
                    ? ctrl.isAdd
                        ? 'Fill required * fields to continue'
                        : 'No changes to update'
                    : null;

                if (msg == null) return const SizedBox.shrink();

                return ZiStateIndicator(
                  message: msg,
                  tone: ZiStateTone.info,
                );
              },
            ),

          if (!ctrl.isView)
            ValueListenableBuilder<bool>(
              valueListenable: ctrl.canSaveNotifier,
              builder: (_, canSave, __) => ZiButtonB(
                expand: true,
                label: ctrl.isEdit ? 'Update Category' : 'Create Category',
                disabled: !canSave,
                action: _onAction,
              ),
            ),
        ],
      ),
    );
  }
}