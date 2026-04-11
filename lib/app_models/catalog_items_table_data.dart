
enum CatalogType { product, service }

extension CatalogTypeX on CatalogType {
  String get label {
    switch (this) {
      case CatalogType.product:
        return "Product";
      case CatalogType.service:
        return "Service";
    }
  }
}

class CatalogItemsTableData {
  final String uuid;
  final int id;
  final String title;
  final double price;
  final String catalogType;
  final String categoryUuid;
  final String? sku;
  final String? brand;
  final int stockQty;
  final int soldCount;
  final String? description;
  final bool isActive;

  CatalogItemsTableData({
    required this.uuid,
    required this.id,
    required this.title,
    required this.price,
    required this.catalogType,
    required this.categoryUuid,
    this.sku,
    this.brand,
    this.stockQty = 0,
    this.soldCount = 0,
    this.description,
    this.isActive = true,
  });
}

class CatalogCategoriesTableData {
  final String uuid;
  final String name;

  CatalogCategoriesTableData({
    required this.uuid,
    required this.name,
  });
}

/// Dummy Data
List<CatalogCategoriesTableData> dummyCategories = [
  CatalogCategoriesTableData(uuid: "1", name: "General"),
  CatalogCategoriesTableData(uuid: "2", name: "Electronics"),
];

List<CatalogItemsTableData> dummyItems = [
  CatalogItemsTableData(
    uuid: "1",
    id: 101,
    title: "iPhone 15",
    price: 250000,
    catalogType: "product",
    categoryUuid: "2",
    sku: "IP15",
    brand: "Apple",
    stockQty: 5,
    soldCount: 2,
    description: "Latest iPhone",
  ),
];