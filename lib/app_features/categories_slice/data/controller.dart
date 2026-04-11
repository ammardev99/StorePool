import 'package:flutter/material.dart';
import 'package:storepool/firebase_services/store/catalog_category_service.dart';
import 'package:zi_core/zi_core_io.dart';
import 'package:storepool/app_models/catalog_categories_table_data.dart';
import 'package:storepool/data/store_enums.dart';

class CategoryController {
  ZiFormMode formMode;
  final String storeId;

  CategoryController({
    required this.storeId,
    this.formMode = ZiFormMode.add,
  }) {
    sync();
  }

  final service = CatalogCategoryService();

  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();

  final canSaveNotifier = ValueNotifier<bool>(false);
  final hasChangesNotifier = ValueNotifier<bool>(false);

  CatalogType selectedType = CatalogType.product;
  bool isLoading = false;
  String origUuid = '';
  String origName = '';
  CatalogType origType = CatalogType.product;

  bool get isAdd => formMode == ZiFormMode.add;
  bool get isEdit => formMode == ZiFormMode.edit;
  bool get isView => formMode == ZiFormMode.view;
 
  bool get hasChanges =>
      nameCtrl.text.trim() != origName || selectedType != origType;

  bool get _canSave =>
      isAdd ? nameCtrl.text.trim().isNotEmpty : hasChanges;

  void notify() => sync();

  void sync() {
    canSaveNotifier.value = _canSave;
    hasChangesNotifier.value = hasChanges;
  }

  void prefill(CatalogCategoriesTableData category) {
    origUuid = category.uuid;
    nameCtrl.text = category.name;

    selectedType = category.typeEnum;

    origName = category.name;
    origType = selectedType;

    sync();
  }

  // 🔥 CREATE
  Future<bool> submit() async {
    if (!formKey.currentState!.validate()) return false;

    await service.createCategory(
      storeId: storeId,
      name: nameCtrl.text.trim(),
      type: selectedType.name,
    );

    return true;
  }

  // 🔥 UPDATE
  Future<bool> update(String uuid) async {
    if (!formKey.currentState!.validate()) return false;

    await service.updateCategory(
      storeId: storeId,
      uuid: uuid,
      name: nameCtrl.text.trim(),
    );

    return true;
  }

  // 🔥 DELETE
  Future<void> delete(String uuid) async {
    await service.deleteCategory(storeId: storeId, uuid: uuid);
  }

  void dispose() {
    nameCtrl.dispose();
    canSaveNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}