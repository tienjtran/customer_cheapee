class ProductModel {
  int id;
  String name;
  double price;
  double discountedPrice;
  int remainingDays;
  String imagePath;

  ProductModel(this.id, this.name, this.price, this.discountedPrice,
      this.remainingDays, this.imagePath);

  get getId => this.id;
  set setId(id) => this.id = id;
  get getName => this.name;
  set setName(name) => this.name = name;
  get getPrice => this.price;
  set setPrice(price) => this.price = price;
  get getDiscountedPrice => this.discountedPrice;
  set setDiscountedPrice(discountedPrice) =>
      this.discountedPrice = discountedPrice;
  get getRemainingDaysString => this.remainingDays.toString();
  set setRemainingDays(remainingDays) => this.remainingDays = remainingDays;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
}
