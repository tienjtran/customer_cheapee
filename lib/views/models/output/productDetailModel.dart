class SuggestedProductModel {
  String name; //tên sản phẩm
  String imagePath; //link hình ảnh
  String price; //giá niêm yết
  String salePrice; //giá đã giảm
  String expiryDate; //HSD

  SuggestedProductModel(
      this.name, this.imagePath, this.price, this.salePrice, this.expiryDate);

  get getName => this.name;
  set setName(String name) => this.name = name;

  get getImagePath => this.imagePath;
  set setImagePath(String imagePath) => this.imagePath = imagePath;

  get getPrice => this.price;
  set setPrice(String price) => this.price = price;

  get getSalePrice => this.salePrice;
  set setSalePrice(String salePrice) => this.salePrice = salePrice;

  get getExpiryDate => this.expiryDate;
  set setExpiryDate(String expiryDate) => this.expiryDate = expiryDate;
}
