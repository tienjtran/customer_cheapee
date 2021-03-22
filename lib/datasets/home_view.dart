class ProductInNearStoreDataset {
  final int storeId;
  final String storeName;
  final String imagePath;
  final double distance;
  final int openTime;
  final int closeTime;
  final List<ProductListDataset> productList;

  ProductInNearStoreDataset(
      {this.storeId,
      this.storeName,
      this.imagePath,
      this.distance,
      this.openTime,
      this.closeTime,
      this.productList});

  factory ProductInNearStoreDataset.fromJson(Map<String, dynamic> json) {
    var list = json['productList'] as List;
    List<ProductListDataset> productList =
        list.map((i) => ProductListDataset.fromJson(i)).toList();
    return ProductInNearStoreDataset(
        storeId: json['storeID'] as int,
        storeName: json['storeName'] as String,
        imagePath: json['imagePath'] as String,
        distance: json['distance'] as double,
        openTime: json['openTime'] as int,
        closeTime: json['closeTime'] as int,
        productList: productList);
  }
}

class ProductListDataset {
  final int productInStoreId;
  final String name;
  final String imagePath;
  final double oldPrice;
  final double salePrice;
  final DateTime manufactureDate;
  final DateTime expireDate;

  ProductListDataset(
      {this.productInStoreId,
      this.name,
      this.imagePath,
      this.oldPrice,
      this.salePrice,
      this.manufactureDate,
      this.expireDate});

  factory ProductListDataset.fromJson(Map<String, dynamic> json) {
    return ProductListDataset(
        productInStoreId: json['productInStoreID'] as int,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
        oldPrice: (json['oldPrice'] as int).toDouble(),
        salePrice: (json['salePrice'] as int).toDouble(),
        manufactureDate: DateTime.parse(json['manufactureDate'] as String),
        expireDate: DateTime.parse(json['expireDate'] as String));
  }
}
