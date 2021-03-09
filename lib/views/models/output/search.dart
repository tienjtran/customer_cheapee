class SearchResultOutputModel {
  SearchStore store;
  List<SearchItemModel> itemList;

  SearchResultOutputModel(this.store, this.itemList);
}

class SearchStore {
  String storeName;
  int openingTime;
  int closingTime;
  double distance;
  double stars;
  String imagePath;

  SearchStore(this.storeName, this.openingTime, this.closingTime, this.distance,
      this.stars, this.imagePath);

  String get getStoreName => this.storeName;

  set setStoreName(String storeName) => this.storeName = storeName;

  get getOpeningTime => this.openingTime;

  set setOpeningTime(openingTime) => this.openingTime = openingTime;

  get getClosingTime => this.closingTime;

  set setClosingTime(closingTime) => this.closingTime = closingTime;

  get getDistance => this.distance;

  set setDistance(distance) => this.distance = distance;

  get getStars => this.stars;

  set setStars(stars) => this.stars = stars;
}

class SearchItemModel {
  String itemName;
  double price;
  String imagePath;

  SearchItemModel(this.itemName, this.price, this.imagePath);

  String get getItemName => this.itemName;

  set setItemName(String itemName) => this.itemName = itemName;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getImagePath => this.imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
