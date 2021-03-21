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
