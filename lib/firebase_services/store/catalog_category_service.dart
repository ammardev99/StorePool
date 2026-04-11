// ─── Catalog Category Service ───────────────────────────────────────────
// ROLE: Firebase CRUD for categories
// PATH: stores/{storeId}/categories/{categoryId}
// ───────────────────────────────────────────────────────────────────────

import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogCategoryService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref(String storeId) {
    return _db.collection('stores').doc(storeId).collection('categories');
  }

  // ── CREATE ────────────────────────────────────────────────────────────
  Future<String> createCategory({
    required String storeId,
    required String name,
    String? type, // product/service
    bool isSystem = false,
  }) async {
    final doc = _ref(storeId).doc();

    await doc.set({
      "uuid": doc.id,
      "name": name,
      "type": type,
      "isSystem": isSystem,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  // ── GET ALL ───────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getCategories({
    required String storeId,
    String? type,
  }) async {
    Query<Map<String, dynamic>> query = _ref(storeId);

    if (type != null) {
      query = query.where("type", isEqualTo: type);
    }

    final res = await query.get();

    return res.docs.map((e) => e.data()).toList();
  }

  // ── UPDATE ────────────────────────────────────────────────────────────
  Future<void> updateCategory({
    required String storeId,
    required String uuid,
    required String name,
  }) async {
    await _ref(storeId).doc(uuid).update({
      "name": name,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  // ── DELETE ────────────────────────────────────────────────────────────
  Future<void> deleteCategory({
    required String storeId,
    required String uuid,
  }) async {
    await _ref(storeId).doc(uuid).delete();
  }
}
