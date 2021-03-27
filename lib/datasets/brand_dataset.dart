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
