class CartDataset {
  final int storeId;
  final String storeName;
  final String storeAddress;
  final List<ItemCartDataset> productList;

  CartDataset(
      {this.storeId, this.storeName, this.storeAddress, this.productList});

  factory CartDataset.fromJson(Map<String, dynamic> json) {
    var productJson = json['productList'] as List;
    List<ItemCartDataset> prodouctList =
        productJson.map((e) => ItemCartDataset.fromJson(e)).toList();
    return CartDataset(
      storeId: json['storeId'] as int,
      storeName: json['storeName'] as String,
      storeAddress: json['storeAddress'] as String,
      productList: prodouctList,
    );
  }
}

class ItemCartDataset {
  final int productInStoreId;
  final String productName;
  final double oldPrice;
  final double salePrice;
  final int leftDay;
  final String imagePath;

  ItemCartDataset({
    this.productInStoreId,
    this.productName,
    this.oldPrice,
    this.salePrice,
    this.leftDay,
    this.imagePath,
  });

  factory ItemCartDataset.fromJson(Map<String, dynamic> json) {
    return ItemCartDataset(
      productInStoreId: json['productInStoreId'] as int,
      productName: json['productName'] as String,
      oldPrice: json['oldPrice'].toDouble(),
      salePrice: json['salePrice'].toDouble(),
      leftDay: json['leftDay'] as int,
      imagePath: json['imagePath'] as String,
    );
  }
}
