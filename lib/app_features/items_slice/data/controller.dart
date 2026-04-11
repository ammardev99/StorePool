// ─── Zi_Slice: Controller (UI ONLY - NORMALIZED) ─────────────────────────
// ROLE: Form state only. No backend, no providers.
// ─────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart';
import 'package:zi_core/zi_core_io.dart';

class CatalogController {
  ZiFormMode formMode;

  CatalogController({this.formMode = ZiFormMode.add}) {
    _update();
  }

  // ── form ──────────────────────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  // ── notifiers ─────────────────────────────────────────────────────────
  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  // ── non-text fields ───────────────────────────────────────────────────
  CatalogType selectedType = CatalogType.product;
  String? selectedCategoryUuid;
  bool showMore = false;

  String? existingUuid;

  // ── originals (for change detection) ──────────────────────────────────
  String _origName = '';
  String _origPrice = '';
  String _origSku = '';
  String _origBrand = '';
  String _origStock = '';
  String _origDesc = '';
  CatalogType _origType = CatalogType.product;
  String? _origCategoryUuid;

  // ── modes ─────────────────────────────────────────────────────────────
  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;

  String get actionLabel => isEdit ? 'Update' : 'Add';

  // ── computed ──────────────────────────────────────────────────────────
  bool get _canSave =>
      isAdd
          ? nameCtrl.text.trim().isNotEmpty &&
              priceCtrl.text.trim().isNotEmpty
          : _hasChanges;

  bool get _hasChanges =>
      nameCtrl.text.trim() != _origName ||
      priceCtrl.text.trim() != _origPrice ||
      skuCtrl.text.trim() != _origSku ||
      brandCtrl.text.trim() != _origBrand ||
      stockCtrl.text.trim() != _origStock ||
      descCtrl.text.trim() != _origDesc ||
      selectedType != _origType ||
      selectedCategoryUuid != _origCategoryUuid;

  // ── notify ────────────────────────────────────────────────────────────
  void notify() => _update();

  void _update() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = _hasChanges;
  }

  // ── prefill (for edit/view UI) ────────────────────────────────────────
  void prefill(Map<String, dynamic> item) {
    existingUuid = item["uuid"];

    nameCtrl.text = item["title"] ?? '';
    priceCtrl.text = (item["price"] ?? 0).toString();
    skuCtrl.text = item["sku"] ?? '';
    brandCtrl.text = item["brand"] ?? '';
    stockCtrl.text = (item["stockQty"] ?? 0).toString();
    descCtrl.text = item["description"] ?? '';

    selectedCategoryUuid = item["categoryUuid"];

    showMore =
        skuCtrl.text.isNotEmpty ||
        brandCtrl.text.isNotEmpty ||
        descCtrl.text.isNotEmpty;

    // snapshot originals
    _origName = nameCtrl.text;
    _origPrice = priceCtrl.text;
    _origSku = skuCtrl.text;
    _origBrand = brandCtrl.text;
    _origStock = stockCtrl.text;
    _origDesc = descCtrl.text;
    _origType = selectedType;
    _origCategoryUuid = selectedCategoryUuid;

    _update();
  }

  // ── submit (UI ONLY) ──────────────────────────────────────────────────
  Future<bool> submit() async {
    if (!formKey.currentState!.validate()) return false;

    // simulate success (no backend)
    await Future.delayed(const Duration(milliseconds: 300));

    return true;
  }

  // ── update (UI ONLY) ──────────────────────────────────────────────────
  Future<bool> update(String uuid) async {
    if (!formKey.currentState!.validate()) return false;

    await Future.delayed(const Duration(milliseconds: 300));

    return true;
  }

  // ── dispose ───────────────────────────────────────────────────────────
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    skuCtrl.dispose();
    brandCtrl.dispose();
    stockCtrl.dispose();
    descCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}