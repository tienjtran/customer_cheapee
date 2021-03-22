import 'package:customer_cheapee/datasets/product_dataset.dart';

class ProductInStoreDataset {
  final int productInStoreId;
  final double salePrice;
  final DateTime manufactureDate;
  final DateTime expireDate;
  final String description;
  final int quantity;
  final ProductDataset product;

  ProductInStoreDataset({
    this.productInStoreId,
    this.salePrice,
    this.manufactureDate,
    this.expireDate,
    this.description,
    this.quantity,
    this.product,
  });

  factory ProductInStoreDataset.fromJson(Map<String, dynamic> json) {
    return ProductInStoreDataset(
      productInStoreId: json['productInStoreId'] as int,
      salePrice: json['salePrice'].toDouble(),
      manufactureDate: DateTime.parse(json['manufactureDate'] as String),
      expireDate: DateTime.parse(json['expireDate'] as String),
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      product: ProductDataset.fromJson(json['product']),
    );
  }
}
