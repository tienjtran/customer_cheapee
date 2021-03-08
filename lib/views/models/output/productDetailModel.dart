class SuggestedProductModel {
  String name; //tên sản phẩm
  String imagePath; //link hình ảnh
  int discount;
  String salePrice; //giá đã giảm
  String expiryDate; //HSD

  SuggestedProductModel(this.name, this.imagePath, this.discount,
      this.salePrice, this.expiryDate);

  get getName => this.name;
  set setName(String name) => this.name = name;

  get getImagePath => this.imagePath;
  set setImagePath(String imagePath) => this.imagePath = imagePath;

  get getPrice => this.discount;
  set setPrice(int discount) => this.discount = discount;

  get getSalePrice => this.salePrice;
  set setSalePrice(String salePrice) => this.salePrice = salePrice;

  get getExpiryDate => this.expiryDate;
  set setExpiryDate(String expiryDate) => this.expiryDate = expiryDate;
}
