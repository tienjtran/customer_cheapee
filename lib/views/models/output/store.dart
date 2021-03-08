import 'package:customer_cheapee/views/models/output/productDetailModel.dart';

class NearStoreOutputModel {
  String storeName;
  String imagePath;
  double distance;
  List<SuggestedProductModel> productList;

  NearStoreOutputModel(
      this.storeName, this.imagePath, this.distance, this.productList);

  double get getDistance => this.distance;

  set setDistance(double distance) => this.distance = distance;

  String get getImagePath => this.imagePath;

  set setImagePath(String imagePath) => this.imagePath = imagePath;

  get getStoreName => this.storeName;

  set setStoreName(storeName) => this.storeName = storeName;

  get getProductList => this.productList;

  set setProductList(productList) => this.productList = productList;
}
