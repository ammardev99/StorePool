import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_items_table_data.dart';
import 'package:storepool/firebase_services/store/catalog_item_service.dart';
import 'package:zi_core/zi_core_io.dart';

class CatalogController {
  ZiFormMode formMode;

  CatalogController({this.formMode = ZiFormMode.add}) {
    _update();
  }

  // 🔥 REQUIRED
  String? storeId;

  final CatalogItemService _service = CatalogItemService();

  // ── form ──────────────────────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  // ✅ ZiLoading style
  bool isLoading = false;

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

  // ── prefill ───────────────────────────────────────────────────────────
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

  // ── CREATE ────────────────────────────────────────────────────────────
  Future<bool> submit() async {
    if (!formKey.currentState!.validate()) return false;
    if (storeId == null) return false;

    isLoading = true;

    try {
      await _service.createItem(
        storeId: storeId!,
        title: nameCtrl.text.trim(),
        price: double.parse(priceCtrl.text.trim()),
        categoryUuid: selectedCategoryUuid ?? '',
        catalogType: selectedType.name,
        sku: skuCtrl.text.trim(),
        brand: brandCtrl.text.trim(),
        stockQty: int.tryParse(stockCtrl.text) ?? 0,
        description: descCtrl.text.trim(),
      );

      isLoading = false;
      return true;
    } catch (e) {
      isLoading = false;
      return false;
    }
  }

  // ── UPDATE ────────────────────────────────────────────────────────────
  Future<bool> update(String uuid) async {
    if (!formKey.currentState!.validate()) return false;
    if (storeId == null) return false;

    isLoading = true;

    try {
      await _service.updateItem(
        storeId: storeId!,
        uuid: uuid,
        title: nameCtrl.text.trim(),
        price: double.parse(priceCtrl.text.trim()),
        categoryUuid: selectedCategoryUuid ?? '',
        catalogType: selectedType.name,
        sku: skuCtrl.text.trim(),
        brand: brandCtrl.text.trim(),
        stockQty: int.tryParse(stockCtrl.text) ?? 0,
        description: descCtrl.text.trim(),
      );

      isLoading = false;
      return true;
    } catch (e) {
      isLoading = false;
      return false;
    }
  }

  // ── DELETE ────────────────────────────────────────────────────────────
  Future<bool> delete(String uuid) async {
    if (storeId == null) return false;

    isLoading = true;

    try {
      await _service.deleteItem(
        storeId: storeId!,
        uuid: uuid,
      );

      isLoading = false;
      return true;
    } catch (e) {
      isLoading = false;
      return false;
    }
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