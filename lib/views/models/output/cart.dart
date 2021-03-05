import 'package:flutter/cupertino.dart';

class CartItemOutputModel {
  String name;
  String imagePath;

  double oldPrice;
  double currentPrice;
  int leftDays;
  int quantity;
  bool checked;

  CartItemOutputModel(this.name, this.imagePath, this.oldPrice,
      this.currentPrice, this.leftDays, this.quantity, this.checked);

  String get getImagePath => this.imagePath;

  set setImagePath(String imagePath) => this.imagePath = imagePath;
  bool get getChecked => this.checked;

  set setChecked(bool checked) => this.checked = checked;

  String get getName => this.name;

  set setName(String name) => this.name = name;

  get getOldPrice => this.oldPrice;

  set setOldPrice(oldPrice) => this.oldPrice = oldPrice;

  get getCurrentPrice => this.currentPrice;

  set setCurrentPrice(currentPrice) => this.currentPrice = currentPrice;

  get getLeftDays => this.leftDays;

  set setLeftDays(leftDays) => this.leftDays = leftDays;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;
}
