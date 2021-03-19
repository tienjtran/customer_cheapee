class LoadingCartInput {
  int storeId;
  List<int> productList = new List();

  LoadingCartInput({
    this.storeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'productList': productList,
    };
  }
}
