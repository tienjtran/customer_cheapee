class SuggestedProductModel {
  String name; //tên sản phẩm
  String imagePath; //link hình ảnh
  double discount;
  String salePrice; //giá đã giảm
  String expiryDate; //HSD
  int category; // Phân loại
  bool suggested; // Sản phầm được gợi ý

  SuggestedProductModel(this.name, this.imagePath, this.discount,
      this.salePrice, this.expiryDate, this.category, this.suggested);

  get getName => this.name;
  set setName(String name) => this.name = name;

  get getImagePath => this.imagePath;
  set setImagePath(String imagePath) => this.imagePath = imagePath;

  get getPrice => this.discount;
  set setPrice(double discount) => this.discount = discount;

  get getSalePrice => this.salePrice;
  set setSalePrice(String salePrice) => this.salePrice = salePrice;

  get getExpiryDate => this.expiryDate;
  set setExpiryDate(String expiryDate) => this.expiryDate = expiryDate;

  get getCategory => this.category;
  set setCategory(category) => this.category = category;

  get getSuggested => this.suggested;
  set setSuggested(suggested) => this.suggested = suggested;
}
