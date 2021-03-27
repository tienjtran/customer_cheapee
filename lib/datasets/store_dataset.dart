class StoreDataset {
  final int storeID;
  final String storeName;
  final String imagePath;
  final int openTime;
  final int closeTime;
  // final ProductDataset productList;

  StoreDataset({
    this.storeID,
    this.storeName,
    this.imagePath,
    this.openTime,
    this.closeTime,
  });

  factory StoreDataset.fromJson(Map<String, dynamic> json) {
    return StoreDataset(
      storeID: json['storeID'] as int,
      storeName: json['storeName'] as String,
      imagePath: json['imagePath'] as String,
      openTime: json['openTime'] as int,
      closeTime: json['closeTime'] as int,
    );
  }
}
