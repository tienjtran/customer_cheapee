import 'package:customer_cheapee/views/models/output/product.dart';

class OrderModel {
  int id;
  String name;
  int quantity;
  double total;
  String imagePath;
  ProductModel product;

  OrderModel(
      this.name, this.quantity, this.total, this.imagePath, this.product);

  get getName => this.name;
  set setName(name) => this.name = name;
  get getQuantity => this.quantity;
  set setQuantity(quantity) => this.quantity = quantity;
  get getTotal => this.total;
  set setTotal(total) => this.total = total;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
  get getProduct => this.product;
  set setProduct(product) => this.product = product;
}
