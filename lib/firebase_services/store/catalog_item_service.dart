// ─── Catalog Item Service ───────────────────────────────────────────────
// ROLE: Firebase CRUD for items
// PATH: stores/{storeId}/items/{itemId}
// ───────────────────────────────────────────────────────────────────────

import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogItemService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref(String storeId) {
    return _db.collection('stores').doc(storeId).collection('items');
  }

  // ── CREATE ────────────────────────────────────────────────────────────
  Future<String> createItem({
    required String storeId,
    required String title,
    required double price,
    required String categoryUuid,
    required String catalogType, // product/service

    String? sku,
    String? brand,
    int stockQty = 0,
    String? description,
  }) async {
    final doc = _ref(storeId).doc();

    await doc.set({
      "uuid": doc.id,
      "title": title,
      "price": price,
      "categoryUuid": categoryUuid,
      "catalogType": catalogType,

      "sku": sku,
      "brand": brand,
      "stockQty": stockQty,
      "description": description,

      "isActive": true,
      "soldCount": 0,

      "createdAt": FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  // ── GET (PAGINATED READY) ─────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getItems({
    required String storeId,
    String? type,
  }) async {
    Query<Map<String, dynamic>> query = _ref(storeId);
   

    if (type != null) {
      query = query.where("catalogType", isEqualTo: type);
    }

    final res = await query.get();

    return res.docs.map((e) => e.data()).toList();
  }

  // ── UPDATE ────────────────────────────────────────────────────────────
  Future<void> updateItem({
    required String storeId,
    required String uuid,

    required String title,
    required double price,
    required String categoryUuid,
    required String catalogType,

    String? sku,
    String? brand,
    int stockQty = 0,
    String? description,
  }) async {
    await _ref(storeId).doc(uuid).update({
      "title": title,
      "price": price,
      "categoryUuid": categoryUuid,
      "catalogType": catalogType,

      "sku": sku,
      "brand": brand,
      "stockQty": stockQty,
      "description": description,

      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  // ── DELETE ────────────────────────────────────────────────────────────
  Future<void> deleteItem({
    required String storeId,
    required String uuid,
  }) async {
    await _ref(storeId).doc(uuid).delete();
  }

  // ── TOGGLE ACTIVE ─────────────────────────────────────────────────────
  Future<void> toggleActive({
    required String storeId,
    required String uuid,
    required bool isActive,
  }) async {
    await _ref(storeId).doc(uuid).update({"isActive": isActive});
  }
}
