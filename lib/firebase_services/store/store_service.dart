// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storepool/data/store_enums.dart';

class StoreService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  // ────────────────────────────────
  // 📌 CREATE STORE
  // ────────────────────────────────
  Future<String> createStore({
    required String name,
    required String phone,
    required String address,
    required StoreCategory category,
    required StoreCurrency currency,
  }) async {
    try {
      final storeRef = _db.collection('stores').doc();

      await storeRef.set({
        'metadata': {
          'id': storeRef.id,
          'name': name,
          'phone': phone,
          'address': address,
          'category': category.name,
          'currency': currency.name,
          'theme': null,
          'logo': null,
          'ownerId': _uid,
          'isPinEnabled': false,
          'pin': null,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        'dashboard': {
          'totalOrders': 0,
          'pendingOrders': 0,
          'totalItems': 0,
          'revenue': 0,
          'profitLoss': 0,
        },
      });

      final userRef = _db.collection('users').doc(_uid);
      await userRef.update({
        'stores_owned': FieldValue.arrayUnion([storeRef.id]),
        'hasStore': true,
      });

      return storeRef.id;
    } catch (e) {
      throw Exception("Failed to create store: $e");
    }
  }

  // ────────────────────────────────
  // 📌 GET STORE (BY STORE ID)
  // ────────────────────────────────
  Future<DocumentSnapshot<Map<String, dynamic>>?> getStore(String storeId) async {
    final doc = await _db.collection('stores').doc(storeId).get();
    return doc.exists ? doc : null;
  }

  // ────────────────────────────────
  // 📌 GET ALL STORES OF CURRENT USER
  // ────────────────────────────────
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserStores() async {
    final userDoc = await _db.collection('users').doc(_uid).get();
    final storeIds = List<String>.from(userDoc.data()?['stores_owned'] ?? []);
    if (storeIds.isEmpty) return [];

    final storeDocs = await Future.wait(
      storeIds.map((id) => _db.collection('stores').doc(id).get()),
    );

    return storeDocs.where((doc) => doc.exists).cast<DocumentSnapshot<Map<String, dynamic>>>().toList();
  }

  // ────────────────────────────────
  // 📌 UPDATE STORE METADATA
  // ────────────────────────────────
  Future<void> updateStore({
    required String storeId,
    String? name,
    String? phone,
    String? address,
    StoreCategory? category,
    StoreCurrency? currency,
    String? theme,
    String? logo,
  }) async {
    final data = <String, dynamic>{};

    if (name != null) data['metadata.name'] = name;
    if (phone != null) data['metadata.phone'] = phone;
    if (address != null) data['metadata.address'] = address;
    if (category != null) data['metadata.category'] = category.name;
    if (currency != null) data['metadata.currency'] = currency.name;
    if (theme != null) data['metadata.theme'] = theme;
    if (logo != null) data['metadata.logo'] = logo;

    if (data.isNotEmpty) {
      data['metadata.updatedAt'] = FieldValue.serverTimestamp();
      await _db.collection('stores').doc(storeId).update(data);
    }
  }

  // ────────────────────────────────
  // 📌 DELETE STORE
  // ────────────────────────────────
  Future<void> deleteStore(String storeId) async {
    try {
      await _db.collection('stores').doc(storeId).delete();

      final userRef = _db.collection('users').doc(_uid);
      await userRef.update({
        'stores_owned': FieldValue.arrayRemove([storeId]),
      });

      final userDoc = await userRef.get();
      final remainingStores = List.from(userDoc.data()?['stores_owned'] ?? []);
      await userRef.update({'hasStore': remainingStores.isNotEmpty});
    } catch (e) {
      throw Exception("Failed to delete store: $e");
    }
  }

  // ────────────────────────────────
  // 📌 PIN HANDLING
  // ────────────────────────────────
  Future<void> setOrUpdatePin({required String storeId, required String newPin}) async {
    await _db.collection('stores').doc(storeId).update({
      'metadata.pin': newPin,
      'metadata.isPinEnabled': true,
      'metadata.updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> disablePin(String storeId) async {
    await _db.collection('stores').doc(storeId).update({
      'metadata.pin': null,
      'metadata.isPinEnabled': false,
      'metadata.updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ────────────────────────────────
  // 📌 DASHBOARD UPDATES (AGGREGATES)
  // ────────────────────────────────
  Future<void> updateDashboard({
    required String storeId,
    int? totalOrders,
    int? pendingOrders,
    int? totalItems,
    double? revenue,
    double? profitLoss,
  }) async {
    final data = <String, dynamic>{};
    if (totalOrders != null) data['dashboard.totalOrders'] = totalOrders;
    if (pendingOrders != null) data['dashboard.pendingOrders'] = pendingOrders;
    if (totalItems != null) data['dashboard.totalItems'] = totalItems;
    if (revenue != null) data['dashboard.revenue'] = revenue;
    if (profitLoss != null) data['dashboard.profitLoss'] = profitLoss;

    if (data.isNotEmpty) {
      await _db.collection('stores').doc(storeId).update(data);
    }
  }

  // ────────────────────────────────
  // 📌 CHECK IF USER HAS ANY STORE
  // ────────────────────────────────
  Future<bool> hasStore() async {
    final doc = await _db.collection('users').doc(_uid).get();
    return doc.data()?['hasStore'] ?? false;
  }
}