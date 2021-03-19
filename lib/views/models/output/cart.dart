class CartOutputModel {
  int storeId;
  String storeName;
  String storeAddress;
  List<CartItemOutputModel> productList = new List();
  CartOutputModel(this.storeId, this.storeName, this.storeAddress);
}

class CartItemOutputModel {
  int productId;
  String name;
  String imagePath;

  double oldPrice;
  double currentPrice;
  int leftDays;
  int quantity;

  CartItemOutputModel(
      {this.productId,
      this.name,
      this.imagePath,
      this.oldPrice,
      this.currentPrice,
      this.leftDays,
      this.quantity});

  int get getProductId => this.productId;

  set setProductId(int productId) => this.productId = productId;

  String get getImagePath => this.imagePath;

  set setImagePath(String imagePath) => this.imagePath = imagePath;

  String get getName => this.name;

  set setName(String name) => this.name = name;

  get getOldPrice => this.oldPrice;

  set setOldPrice(oldPrice) => this.oldPrice = oldPrice;

  get getCurrentPrice => this.currentPrice;

  set setCurrentPrice(currentPrice) => this.currentPrice = currentPrice;

  get getLeftDays => this.leftDays;

  set setLeftDays(leftDays) => this.leftDays = leftDays;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;
}
