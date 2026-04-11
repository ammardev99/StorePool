import 'package:flutter/material.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:zi_core/zi_core_io.dart';

class CategoryController {
  ZiFormMode formMode;

  CategoryController({this.formMode = ZiFormMode.add}) {
    _sync();
  }

  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();

  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  CatalogType selectedType = CatalogType.product;

  String origUuid = '';
  String origName = '';
  CatalogType _origType = CatalogType.product;

  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;

  bool get _hasChanges =>
      nameCtrl.text.trim() != origName || selectedType != _origType;

  bool get _canSave =>
      isAdd ? nameCtrl.text.trim().isNotEmpty : _hasChanges;

  void notify() => _sync();

  void _sync() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = _hasChanges;
  }

  void prefill(CatalogCategoriesTableData category) {
    origUuid = category.uuid;
    nameCtrl.text = category.name;

    selectedType = category.typeEnum;

    origName = category.name;
    _origType = selectedType;

    _sync();
  }

  /// =========================
  /// 🟢 DUMMY OPERATIONS ONLY
  /// =========================

  Future<bool> submit() async {
    if (!formKey.currentState!.validate()) return false;
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> update(String uuid) async {
    if (!formKey.currentState!.validate()) return false;
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<void> delete(String uuid, CatalogType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  void dispose() {
    nameCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}