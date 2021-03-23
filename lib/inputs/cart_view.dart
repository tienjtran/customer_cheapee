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

class PlaceOrderInput {
  final String uid;
  final String email;

  PlaceOrderInput({this.uid, this.email});

  Map<String, dynamic> toJson() {
    return {
      'userIdentifier': uid,
      'email': email,
    };
  }
}
