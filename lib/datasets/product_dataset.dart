class ProductInStoreDataset {
  final int productInStoreId;
  final double salePrice;
  final DateTime manufactureDate;
  final DateTime expireDate;
  final ProductDataset product;

  ProductInStoreDataset({
    this.productInStoreId,
    this.salePrice,
    this.manufactureDate,
    this.expireDate,
    this.product,
  });

  factory ProductInStoreDataset.fromJson(Map<String, dynamic> json) {
    return ProductInStoreDataset(
      productInStoreId: json['productInStoreID'] as int,
      salePrice: (json['salePrice'] as int).toDouble(),
      manufactureDate: DateTime.parse(json['manufactureDate'] as String),
      expireDate: DateTime.parse(json['expireDate'] as String),
      product: ProductDataset.fromJson(json['product']),
    );
  }
}

class ProductDataset {
  int id;
  String name;
  String barcode;
  double price;
  int manufacturerid;
  int imagePathid;
  int brandid;
  int categoryid;

  ProductDataset({
    this.id,
    this.name,
    this.barcode,
    this.price,
    this.manufacturerid,
    this.imagePathid,
    this.brandid,
    this.categoryid,
  });

  factory ProductDataset.fromJson(Map<String, dynamic> json) {
    return ProductDataset(
      id: json['productId'] as int,
      name: json['name'] as String,
      barcode: json['barcode'] as String,
      price: (json['price'] as int).toDouble(),
      manufacturerid: json['manufacturerId'] as int,
      imagePathid: json['photoId'] as int,
      brandid: json['brandId'] as int,
      categoryid: json['categoryId'] as int,
    );
  }
}
