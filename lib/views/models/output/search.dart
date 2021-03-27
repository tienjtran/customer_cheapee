class SearchResultOutputModel {
  SearchStore store;
  List<SearchItemModel> itemList;

  SearchResultOutputModel(this.store, this.itemList);
}

class SearchStore {
  int storeId;
  String storeName;
  int openingTime;
  int closingTime;
  double distance;
  double stars;
  String imagePath;

  SearchStore(this.storeId, this.storeName, this.openingTime, this.closingTime,
      this.distance, this.stars, this.imagePath);

  int get getStoreId => this.storeId;

  set setStoreId(int storeId) => this.storeId = storeId;

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
  int itemId;
  String itemName;
  double price;
  String imagePath;
  int storeId;

  SearchItemModel(
      this.itemId, this.itemName, this.price, this.imagePath, this.storeId);

  int get getStoreId => this.storeId;

  set setStoreId(int storeId) => this.storeId = storeId;

  int get getItemId => this.itemId;

  set setItemId(int itemName) => this.itemId = itemId;

  String get getItemName => this.itemName;

  set setItemName(String itemName) => this.itemName = itemName;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getImagePath => this.imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
