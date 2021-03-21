class OrderDataset {
  final int orderId;
  final DateTime orderDate;
  final DateTime confirmedDate;
  final double total;
  final String emailAddress;
  final int storeId;
  final int process;

  OrderDataset({
    this.orderId,
    this.orderDate,
    this.confirmedDate,
    this.total,
    this.emailAddress,
    this.storeId,
    this.process,
  });

  factory OrderDataset.fromJson(Map<String, dynamic> json) {
    return OrderDataset(
      orderId: json['orderId'] as int,
      orderDate: DateTime.parse(json['orderDate'] as String),
      confirmedDate: DateTime.parse(json['confirmedDate'] as String),
      total: json['total'].toDouble(), //fuck Dart JSON parser
      emailAddress: json['emailAddress'] as String,
      storeId: json['storeId'] as int,
      process: json['process'] as int,
    );
  }
}

class OrderDetailDataset {
  int orderDetailId;
  int productInStoreId;
  int quantity;
  int orderId;
  double price;

  OrderDetailDataset({
    this.orderDetailId,
    this.productInStoreId,
    this.quantity,
    this.orderId,
    this.price,
  });

  factory OrderDetailDataset.fromJson(Map<String, dynamic> json) {
    return OrderDetailDataset(
      orderDetailId: json['orderDetailId'] as int,
      productInStoreId: json['productInStoreId'] as int,
      quantity: json['quantity'] as int,
      orderId: json['orderId'] as int,
      price: json['price'].toDouble(), //fuck Dart JSON parser
    );
  }
}
