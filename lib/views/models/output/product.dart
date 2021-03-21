import 'package:intl/intl.dart';

class ProductModel {
  int id;
  String name;
  double price;
  double discountedPrice;
  DateTime expiryDate;
  String imagePath;

  ProductModel(this.id, this.name, this.price, this.discountedPrice,
      this.expiryDate, this.imagePath);

  get getId => this.id;
  set setId(id) => this.id = id;
  get getName => this.name;
  set setName(name) => this.name = name;
  get getPrice => this.price;
  set setPrice(price) => this.price = price;
  get getDiscountedPrice => this.discountedPrice;
  set setDiscountedPrice(discountedPrice) =>
      this.discountedPrice = discountedPrice;
  get getRemainingDaysString =>
      DateFormat('dd-MM-yyyy').format(this.expiryDate);
  set setRemainingDays(expiryDate) => this.expiryDate = expiryDate;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
}
