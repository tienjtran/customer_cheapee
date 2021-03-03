import 'package:flutter/cupertino.dart';

class SearchResultOutputModel {
  String imagePath;
  String name;
  String category;
  int daysLeft;
  double oldPrice;
  double currentPrice;
  bool isLike;

  SearchResultOutputModel(
      {this.imagePath,
      this.name,
      this.category,
      this.daysLeft,
      this.oldPrice,
      this.currentPrice,
      this.isLike});

  get getIsLike => this.isLike;

  set setIsLike(isLike) => this.isLike = isLike;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getCategory => this.category;

  set setCategory(category) => this.category = category;

  get getDaysLeft => this.daysLeft;

  set setDaysLeft(daysLeft) => this.daysLeft = daysLeft;

  get getOldPrice => this.oldPrice;

  set setOldPrice(oldPrice) => this.oldPrice = oldPrice;

  get getCurrentPrice => this.currentPrice;

  set setCurrentPrice(currentPrice) => this.currentPrice = currentPrice;
}
