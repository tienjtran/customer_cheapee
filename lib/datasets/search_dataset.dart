class SearchStoreDataset {
  final int storeId;
  final String storeName;
  final String imagePath;
  final double distance;
  final int openTime;
  final int closeTime;
  final double stars;
  final List<ProductListDataset> productList;

  SearchStoreDataset(
      {this.storeId,
      this.storeName,
      this.imagePath,
      this.distance,
      this.openTime,
      this.closeTime,
      this.stars,
      this.productList});

  factory SearchStoreDataset.fromJson(Map<String, dynamic> json) {
    var list = json['productList'] as List;
    List<ProductListDataset> imagesList =
        list.map((i) => ProductListDataset.fromJson(i)).toList();
    return SearchStoreDataset(
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
        oldPrice: json['oldPrice'].toDouble(),
        salePrice: json['salePrice'].toDouble(),
        manufactureDate: DateTime.parse(json['manufactureDate'] as String),
        expireDate: DateTime.parse(json['expireDate'] as String));
  }
}
