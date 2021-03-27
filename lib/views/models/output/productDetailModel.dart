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
  String imagePath; //link hình ảnh
  double discount;
  double salePrice; //giá đã giảm
  double originalPrice;
  String expiryDate; //HSD
  String description;
  String manufacturerName;
  String brandName;
  int categoryid;
  int remainingDays;
  int quantity;
  int storeId;

  ProductDetailModel(
    this.productInStoreId,
    this.name,
    this.imagePath,
    this.salePrice,
    this.originalPrice,
    this.expiryDate,
    this.description,
    this.manufacturerName,
    this.brandName,
    this.categoryid,
    this.quantity,
    this.storeId,
  );

  get getStoreId => this.storeId;
  set setStoreId(storeId) => this.storeId = storeId;

  get getProductInStoreId => this.productInStoreId;
  set setProductInStoreId(productInStoreId) =>
      this.productInStoreId = productInStoreId;

  get getName => this.name;
  set setName(name) => this.name = name;

  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;

  get getDiscount => 100 - (this.salePrice / this.originalPrice * 100);
  set setDiscount(discount) => this.discount = discount;

  get getSalePrice => this.salePrice;
  set setSalePrice(salePrice) => this.salePrice = salePrice;

  get getExpiryDate => this.expiryDate;
  set setExpiryDate(expiryDate) => this.expiryDate = expiryDate;

  get getDescription => this.description;
  set setDescription(description) => this.description = description;

  get getManufacturerName => this.manufacturerName;
  set setManufacturerName(manufacturerName) =>
      this.manufacturerName = manufacturerName;

  get getBrandName => this.brandName;
  set setBrandName(brandName) => this.brandName = brandName;

  get getCategoryid => this.categoryid;
  set setCategoryid(categoryid) => this.categoryid = categoryid;

  get getRemainingDays =>
      DateTime.parse(this.expiryDate).difference(new DateTime.now()).inDays;
  set setRemainingDays(remainingDays) => this.remainingDays = remainingDays;
}
