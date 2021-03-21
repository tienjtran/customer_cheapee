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

class BrandDataset {
  int brandId;
  String name;
  int photoId;

  BrandDataset({
    this.brandId,
    this.name,
    this.photoId,
  });

  factory BrandDataset.fromJson(Map<String, dynamic> json) {
    return BrandDataset(
      brandId: json['brandId'] as int,
      name: json['name'] as String,
      photoId: json['photoId'] as int,
    );
  }
}

class ManufacturerDataset {
  int manufacturerId;
  String fullname;
  String shortname;
  int photoId;

  ManufacturerDataset({
    this.manufacturerId,
    this.fullname,
    this.shortname,
    this.photoId,
  });

  factory ManufacturerDataset.fromJson(Map<String, dynamic> json) {
    return ManufacturerDataset(
      manufacturerId: json['brandId'] as int,
      fullname: json['fullname'] as String,
      shortname: json['shortname'] as String,
      photoId: json['photoId'] as int,
    );
  }
}

class PhotoDataset {
  int photoId;
  String url;

  PhotoDataset({
    this.photoId,
    this.url,
  });

  factory PhotoDataset.fromJson(Map<String, dynamic> json) {
    return PhotoDataset(
      photoId: json['photoId'] as int,
      url: json['url'] as String,
    );
  }
}
