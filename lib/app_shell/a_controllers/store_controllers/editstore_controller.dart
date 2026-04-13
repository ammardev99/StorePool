import 'package:flutter/material.dart';
import 'package:storepool/data/store_enums.dart';
import 'package:storepool/firebase_services/store/store_service.dart';

class EditStoreController {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  StoreCategory selectedCategory = StoreCategory.retail;
  StoreCurrency selectedCurrency = StoreCurrency.pkr;

  final _service = StoreService();
  String? storeId;

  bool isLoading = false;

  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
  }

  bool get isValid {
    return nameCtrl.text.isNotEmpty &&
        phoneCtrl.text.isNotEmpty &&
        addressCtrl.text.isNotEmpty;
  }

  Future<void> loadStore(String storeIdParam) async {
    final doc = await _service.getStore(storeIdParam);
    if (doc == null) return;

    final data = doc.data() as Map<String, dynamic>;
    final metadata = data['metadata'] as Map<String, dynamic>;

    storeId = doc.id;
    nameCtrl.text = metadata['name'] ?? '';
    phoneCtrl.text = metadata['phone'] ?? '';
    addressCtrl.text = metadata['address'] ?? '';

    selectedCategory = StoreCategory.values.firstWhere(
      (e) => e.name == metadata['category'],
      orElse: () => StoreCategory.retail,
    );

    selectedCurrency = StoreCurrency.values.firstWhere(
      (e) => e.name == metadata['currency'],
      orElse: () => StoreCurrency.pkr,
    );
  }

  void setCategory(StoreCategory value) => selectedCategory = value;
  void setCurrency(StoreCurrency value) => selectedCurrency = value;

 Future<void> updateStore(BuildContext context, VoidCallback onStateChange) async {
  if (!isValid || storeId == null) return;

  try {
    isLoading = true;
    onStateChange();

    await _service.updateStore(
      storeId: storeId!,
      name: nameCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      address: addressCtrl.text.trim(),
      category: selectedCategory,
      currency: selectedCurrency,
    );
 // ignore: use_build_context_synchronously
 ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Store updated successfully"), backgroundColor: Colors.green),
  );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  } catch (e) {
    debugPrint("Error updating store: $e");
  } finally {
    isLoading = false;
    onStateChange();
  }
}
}