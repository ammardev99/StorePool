import 'package:storepool/data/store_enums.dart';

class CatalogCategoriesTableData {
  final String uuid;
  final String name;
  final String catalogType;
  final bool isSystem;

  const CatalogCategoriesTableData({
    required this.uuid,
    required this.name,
    required this.catalogType,
    required this.isSystem,
  });

  // 🔥 FROM FIREBASE
  factory CatalogCategoriesTableData.fromMap(Map<String, dynamic> map) {
    return CatalogCategoriesTableData(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
      catalogType: map['type'] ?? 'product', // 🔥 IMPORTANT
      isSystem: map['isSystem'] ?? false,
    );
  }

  // 🔥 TO FIREBASE (future use)
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "name": name,
      "type": catalogType,
      "isSystem": isSystem,
    };
  }

  CatalogType get typeEnum {
    return CatalogType.values.firstWhere(
      (e) => e.name == catalogType,
      orElse: () => CatalogType.product,
    );
  }
}