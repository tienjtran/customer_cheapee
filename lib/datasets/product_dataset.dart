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
      price: json['price'].toDouble(),
      manufacturerid: json['manufacturerId'] as int,
      imagePathid: json['photoId'] as int,
      brandid: json['brandId'] as int,
      categoryid: json['categoryId'] as int,
    );
  }
}
