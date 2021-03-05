class OrderModel{
  String name;
  int quantity;
  double total;
  String imagePath;

  OrderModel(this.name, this.quantity, this.total, this.imagePath);

  get getName => this.name;
  set setName(name) => this.name = name;
  get getQuantity => this.quantity;
  set setQuantity(quantity) => this.quantity = quantity;
  get getTotal => this.total;
  set setTotal(total) => this.total = total;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
}

