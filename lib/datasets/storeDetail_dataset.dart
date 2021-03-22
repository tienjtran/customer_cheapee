class StoreDetailDataset {
  final int storeId;
  final String storeName;
  final String imagePath;
  final double distance;
  final int openTime;
  final int closeTime;
  final List<ProductListDataset> productList;

  StoreDetailDataset(
      {this.storeId,
      this.storeName,
      this.imagePath,
      this.distance,
      this.openTime,
      this.closeTime,
      this.productList});

  factory StoreDetailDataset.fromJson(Map<String, dynamic> json) {
    var list = json['productList'] as List;
    List<ProductListDataset> imagesList =
        list.map((i) => ProductListDataset.fromJson(i)).toList();
    return StoreDetailDataset(
        storeId: json['storeID'] as int,
        storeName: json['storeName'] as String,
        imagePath: json['imagePath'] as String,
        distance: json['distance'] as double,
        openTime: json['openTime'] as int,
        closeTime: json['closeTime'] as int,
        productList: imagesList);
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
  final int categoryId;

  ProductListDataset(
      {this.productInStoreId,
      this.name,
      this.imagePath,
      this.oldPrice,
      this.salePrice,
      this.manufactureDate,
      this.expireDate,
      this.categoryId});

  factory ProductListDataset.fromJson(Map<String, dynamic> json) {
    return ProductListDataset(
        productInStoreId: json['productInStoreID'] as int,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
        oldPrice: (json['oldPrice'] as int).toDouble(),
        salePrice: (json['salePrice'] as int).toDouble(),
        manufactureDate: DateTime.parse(json['manufactureDate'] as String),
        expireDate: DateTime.parse(json['expireDate'] as String),
        categoryId: json['categoryId'] as int);
  }
}
