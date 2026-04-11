enum StoreCategory {
  ePOS,
  // A
  accessoriesStore,
  autoParts,

  // B
  bakery,
  barberShop,
  bikeWorkshop,
  bookShop,
  boutique,

  // C
  cafe,
  carWorkshop,
  clothing,
  computerShop,
  cosmeticsStore,

  // D
  dairyShop,

  // E
  electronics,

  // F
  fastFood,
  fertilizerStore,
  footwear,
  furnitureStore,

  // G
  generalStore,
  grocery,

  // H
  hardwareStore,
  homeAppliances,

  // J
  juiceShop,

  // K
  kiryanaStore,

  // L
  livestockShop,

  // M
  medicalStore,
  mobileShop,

  // O

  // P
  paintStore,
  pharmacy,
  photoStudio,
  printingShop,

  // R
  restaurant,
  retail,

  // S
  salon,
  seedStore,
  stationery,
  sweetsShop,

  // T
  tailoringShop,
  tandoor,
  tyreShop,

  // W
  wholesale,
  pos,
  other,
}

extension StoreCategoryX on StoreCategory {
  String get label {
    switch (this) {
      case StoreCategory.accessoriesStore:
        return 'Accessories Store';
      case StoreCategory.autoParts:
        return 'Auto Parts Store';
      case StoreCategory.bakery:
        return 'Bakery';
      case StoreCategory.barberShop:
        return 'Barber Shop';
      case StoreCategory.bikeWorkshop:
        return 'Bike Workshop';
      case StoreCategory.bookShop:
        return 'Book Shop';
      case StoreCategory.boutique:
        return 'Boutique';
      case StoreCategory.cafe:
        return 'Cafe';
      case StoreCategory.carWorkshop:
        return 'Car Workshop';
      case StoreCategory.clothing:
        return 'Clothing Store';
      case StoreCategory.computerShop:
        return 'Computer Shop';
      case StoreCategory.cosmeticsStore:
        return 'Cosmetics Store';
      case StoreCategory.dairyShop:
        return 'Dairy Shop';
      case StoreCategory.electronics:
        return 'Electronics Store';
      case StoreCategory.ePOS:
        return 'ePOS';
      case StoreCategory.fastFood:
        return 'Fast Food';
      case StoreCategory.fertilizerStore:
        return 'Fertilizer Store';
      case StoreCategory.footwear:
        return 'Footwear Store';
      case StoreCategory.furnitureStore:
        return 'Furniture Store';
      case StoreCategory.generalStore:
        return 'General Store';
      case StoreCategory.grocery:
        return 'Grocery Store';
      case StoreCategory.hardwareStore:
        return 'Hardware Store';
      case StoreCategory.homeAppliances:
        return 'Home Appliances Store';
      case StoreCategory.juiceShop:
        return 'Juice Shop';
      case StoreCategory.kiryanaStore:
        return 'Kiryana Store';
      case StoreCategory.livestockShop:
        return 'Livestock Shop';
      case StoreCategory.medicalStore:
        return 'Medical Store';
      case StoreCategory.mobileShop:
        return 'Mobile Shop';
      case StoreCategory.other:
        return 'Other';
      case StoreCategory.paintStore:
        return 'Paint Store';
      case StoreCategory.pharmacy:
        return 'Pharmacy';
      case StoreCategory.photoStudio:
        return 'Photo Studio';
      case StoreCategory.pos:
        return 'Point of Sale';
      case StoreCategory.printingShop:
        return 'Printing Shop';
      case StoreCategory.restaurant:
        return 'Restaurant';
      case StoreCategory.retail:
        return 'Retail Store';
      case StoreCategory.salon:
        return 'Salon';
      case StoreCategory.seedStore:
        return 'Seed Store';
      case StoreCategory.stationery:
        return 'Stationery Store';
      case StoreCategory.sweetsShop:
        return 'Sweets / Mithai Shop';
      case StoreCategory.tailoringShop:
        return 'Tailoring / Darzi Shop';
      case StoreCategory.tandoor:
        return 'Tandoor / Naan Shop';
      case StoreCategory.tyreShop:
        return 'Tyre Shop';
      case StoreCategory.wholesale:
        return 'Wholesale Store';
    }
  }
}

enum StoreCurrency {
  pkr,
  usd,
  aed,
  gbp,
  eur,
  sar,
}

extension StoreCurrencyX on StoreCurrency {
  String get sign {
    switch (this) {
      case StoreCurrency.pkr: return 'Rs.';
      case StoreCurrency.usd: return '\$';
      case StoreCurrency.aed: return 'AED.';
      case StoreCurrency.gbp: return '£';
      case StoreCurrency.eur: return '€';
      case StoreCurrency.sar: return 'SR.';
    }
  }

  String get label {
    switch (this) {
      case StoreCurrency.pkr: return 'PKR - Rs.';
      case StoreCurrency.usd: return 'USD - \$';
      case StoreCurrency.aed: return 'AED';
      case StoreCurrency.gbp: return 'GBP - £';
      case StoreCurrency.eur: return 'EUR - €';
      case StoreCurrency.sar: return 'SAR - SR';
    }
  }
}



enum CatalogType {
  product,
  service;

  String get label {
    switch (this) {
      case CatalogType.product: return 'Product';
      case CatalogType.service: return 'Service';
    }
  }
}