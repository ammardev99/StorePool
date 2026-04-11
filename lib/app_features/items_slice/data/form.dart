// ─── Zi_Slice: Form (UI ONLY - NORMALIZED) ───────────────────────────────
// ROLE: Pure UI form. No controller, no backend.
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class CatalogForm extends StatefulWidget with ZiFormMixin {
  const CatalogForm({super.key});

  // ── ZiFormMixin (dummy) ───────────────────────────────────────────────
  @override
  ValueNotifier<bool> get hasChanges => ValueNotifier(true);

  @override
  ZiFormMode get mode => ZiFormMode.add;

  @override
  VoidCallback? get onClose => null;

  @override
  State<CatalogForm> createState() => _CatalogFormState();
}

class _CatalogFormState extends State<CatalogForm> {
  final _formKey = GlobalKey<FormState>();

  // ── controllers ──────────────────────────────────────────────────────
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  bool showMore = false;

  // ── dummy categories ─────────────────────────────────────────────────
  final List<Map<String, String>> categories = [
    {"uuid": "1", "name": "General"},
    {"uuid": "2", "name": "Electronics"},
  ];

  Map<String, String>? selectedCategory;

  void _onChange() {
    setState(() {});
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, true); // UI فقط
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // ── name ─────────────────────────────────────────────
          ZiInput(
            label: 'Name *',
            variant: ZiInputVariant.stacked,
            controller: nameCtrl,
            enabled: true,
            onChanged: (_) => _onChange(),
            validator: (v) => v == null || v.isEmpty ? 'Name required' : null,
          ),
          ziGap(12),

          // ── category + price ────────────────────────────────
          Row(
            children: [
              SizedBox(
                width: 150,
                child: ZiSelectB<Map<String, String>>(
                  label: 'Category',
                  hint: 'General',
                  items: categories,
                  value: selectedCategory,
                  itemLabel: (e) => e["name"] ?? '',
                  onChanged: (v) {
                    setState(() => selectedCategory = v);
                  },
                ),
              ),
              ziGap(12),
              Expanded(
                child: ZiInput(
                  label: 'Price *',
                  variant: ZiInputVariant.stacked,
                  controller: priceCtrl,
                  enabled: true,
                  onChanged: (_) => _onChange(),
                  validator:
                      (v) => v == null || v.isEmpty ? 'Price required' : null,
                ),
              ),
            ],
          ),

          ziGap(12),

          // ── more toggle ─────────────────────────────────────
          ZiSwitchB(
            subtitle: "you can add more info",
            value: showMore,
            label: "Add More",
            onChanged: (value) {
              setState(() => showMore = value);
            },
          ),

          // ── optional fields ────────────────────────────────
          if (showMore) ...[
            const Divider(),
            ZiInput(
              label: 'SKU / BarCode',
              variant: ZiInputVariant.stacked,
              controller: skuCtrl,
              enabled: true,
              onChanged: (_) => _onChange(),
            ),
            ziGap(12),
            Row(
              children: [
                Expanded(
                  child: ZiInput(
                    label: 'Brand',
                    variant: ZiInputVariant.stacked,
                    controller: brandCtrl,
                    enabled: true,
                    onChanged: (_) => _onChange(),
                  ),
                ),
                ziGap(12),
                Expanded(
                  child: ZiInput(
                    label: 'Stock Qty',
                    variant: ZiInputVariant.stacked,
                    controller: stockCtrl,
                    enabled: true,
                    onChanged: (_) => _onChange(),
                  ),
                ),
              ],
            ),
            ziGap(12),
            ZiInput(
              label: 'Description',
              variant: ZiInputVariant.stacked,
              type: ZiInputType.multiline,
              controller: descCtrl,
              enabled: true,
              onChanged: (_) => _onChange(),
            ),
          ],

          ziGap(20),

          // ── info message (static) ──────────────────────────
          ZiStateIndicator(
            message: 'Fill required * fields to continue',
            tone: ZiStateTone.info,
          ),

          // ── save button ───────────────────────────────────
          ZiButtonB(
            expand: true,
            label: 'Save',
            action: _onSave,
          ),
        ],
      ),
    );
  }
}