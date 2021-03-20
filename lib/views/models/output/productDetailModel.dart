class SuggestedProductModel {
  int productId;
  String name; //tên sản phẩm
  String imagePath; //link hình ảnh
  double discount;
  String salePrice; //giá đã giảm
  String expiryDate; //HSD
  int category; // Phân loại
  bool suggested; // Sản phầm được gợi ý

  SuggestedProductModel(
      this.productId,
      this.name,
      this.imagePath,
      this.discount,
      this.salePrice,
      this.expiryDate,
      this.category,
      this.suggested);

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

class ProductDetailModel {
  int productInStoreId;
  String name; //tên sản phẩm
  int imagePathid; //link hình ảnh
  double discount;
  double salePrice; //giá đã giảm
  double originalPrice;
  String expiryDate; //HSD
  int manufacturerid;
  int brandid;
  int categoryid;
  int remainingDays;

  ProductDetailModel(
    this.productInStoreId,
    this.name,
    this.imagePathid,
    this.salePrice,
    this.originalPrice,
    this.expiryDate,
    this.manufacturerid,
    this.brandid,
    this.categoryid,
  );

  get getProductInStoreId => this.productInStoreId;
  set setProductInStoreId(productInStoreId) =>
      this.productInStoreId = productInStoreId;

  get getName => this.name;
  set setName(name) => this.name = name;

  get getImagePathid => this.imagePathid;
  set setImagePathid(imagePathid) => this.imagePathid = imagePathid;

  get getDiscount => 100 - (this.salePrice / this.originalPrice * 100);
  set setDiscount(discount) => this.discount = discount;

  get getSalePrice => this.salePrice;
  set setSalePrice(salePrice) => this.salePrice = salePrice;

  get getExpiryDate => this.expiryDate;
  set setExpiryDate(expiryDate) => this.expiryDate = expiryDate;

  get getManufacturerid => this.manufacturerid;
  set setManufacturerid(manufacturerid) => this.manufacturerid = manufacturerid;

  get getBrandid => this.brandid;
  set setBrandid(brandid) => this.brandid = brandid;

  get getCategoryid => this.categoryid;
  set setCategoryid(categoryid) => this.categoryid = categoryid;

  get getRemainingDays =>
      new DateTime.now().difference(DateTime.parse(this.expiryDate)).inDays;
  set setRemainingDays(remainingDays) => this.remainingDays = remainingDays;
}
