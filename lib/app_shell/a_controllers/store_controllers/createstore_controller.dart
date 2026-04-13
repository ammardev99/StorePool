import 'package:flutter/material.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:storepool/firebase_services/store/store_service.dart';
import 'package:zi_core/zi_core_io.dart';

class CreateStoreController {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  StoreCategory selectedCategory = StoreCategory.values.first;
  StoreCurrency selectedCurrency = StoreCurrency.values.first;

  final _service = StoreService();

  bool isLoading = false;

  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
  }

  bool get isValid {
    return nameCtrl.text.trim().isNotEmpty &&
        phoneCtrl.text.trim().isNotEmpty &&
        addressCtrl.text.trim().isNotEmpty;
  }

  Future<void> createStore(BuildContext context) async {
    ZiLogger.log("Attempting to create store with name: ${nameCtrl.text.trim()}");
    if (!isValid) return;

    try {
      isLoading = true;

      await _service.createStore(
        name: nameCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        category: selectedCategory,
        currency: selectedCurrency,
      );
      ZiLogger.log("Store created successfully");

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      ZiLogger.log("Error creating store: $e");
    } finally {
      isLoading = false;
    }
  }

  void setCategory(StoreCategory value) => selectedCategory = value;
  void setCurrency(StoreCurrency value) => selectedCurrency = value;
}
