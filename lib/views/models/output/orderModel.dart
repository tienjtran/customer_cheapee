import 'package:customer_cheapee/views/models/output/product.dart';

class OrderModel {
  String id;
  String name;
  double total;
  String imagePath;
  List<ProductModel> productList;
  List<int> quantityList;
  DateTime orderDate;
  DateTime confirmDate;

  OrderModel(this.id, this.name, this.total, this.imagePath, this.productList,
      this.quantityList, this.orderDate, this.confirmDate);

  get getId => this.id;
  set setId(id) => this.id = id;
  get getName => this.name;
  set setName(name) => this.name = name;
  get getQuantityList => this.quantityList;
  set setQuantityList(quantityList) => this.quantityList = quantityList;
  get getTotal => this.total;
  set setTotal(total) => this.total = total;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
  get getProductList => this.productList;
  set setProductList(productList) => this.productList = productList;
  get getOrderDate => this.orderDate;
  set setOrderDate(orderDate) => this.orderDate = orderDate;
  get getConfirmDate => this.confirmDate;
  set setConfirmDate(confirmDate) => this.confirmDate = confirmDate;
}
