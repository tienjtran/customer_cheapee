import 'package:customer_cheapee/datasets/product_dataset.dart';

class ProductInStoreDataset {
  final int productInStoreId;
  final double salePrice;
  final DateTime manufactureDate;
  final DateTime expireDate;
  final String description;
  final ProductDataset product;

  ProductInStoreDataset({
    this.productInStoreId,
    this.salePrice,
    this.manufactureDate,
    this.expireDate,
    this.description,
    this.product,
  });

  factory ProductInStoreDataset.fromJson(Map<String, dynamic> json) {
    return ProductInStoreDataset(
      productInStoreId: json['productInStoreID'] as int,
      salePrice: (json['salePrice'] as int).toDouble(),
      manufactureDate: DateTime.parse(json['manufactureDate'] as String),
      expireDate: DateTime.parse(json['expireDate'] as String),
      description: json['description'] as String,
      product: ProductDataset.fromJson(json['product']),
    );
  }
}
