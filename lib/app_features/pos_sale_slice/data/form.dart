import 'package:flutter/material.dart';
import 'package:storepool/app_features/pos_sale_slice/data/controller.dart';
import 'package:zi_core/zi_core_io.dart';

class POSSliceForm extends StatefulWidget with ZiFormMixin {
  const POSSliceForm({super.key});

  @override
  State<POSSliceForm> createState() => _POSSliceFormState();
}

class _POSSliceFormState extends State<POSSliceForm> {
  final ctrl = POSSliceController();

  void _onChange() {
    ctrl.onChange();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctrl.formKey,
      child: Column(
        children: [
          ZiInput(
            controller: ctrl.nameCtrl,
            label: 'Item Name',
            variant: ZiInputVariant.stacked,
            enabled: true,
            onChanged: (_) => _onChange(),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),

          ziGap(20),

          Row(
            children: [
              Expanded(
                child: ZiInput(
                  variant: ZiInputVariant.stacked,
                  controller: ctrl.qtyCtrl,
                  enabled: true,

                  label: 'Qty',
                  onChanged: (_) => _onChange(),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZiInput(
                  controller: ctrl.rateCtrl,
                  label: 'Sale Rate',
                  enabled: true,
                  variant: ZiInputVariant.stacked,
                  onChanged: (_) => _onChange(),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),

          ziGap(20),

          /// SAVE BUTTON WITH NOTIFIER
          ValueListenableBuilder(
            valueListenable: ctrl.canSaveNotifier,
            builder: (_, canSave, __) {
              return ZiButtonB(
                expand: true,
                label: "Save",
                action: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
}
