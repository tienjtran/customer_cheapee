import 'package:matcher/matcher.dart';

class SuggestedItemModel {
  String imagePath;
  String text;

  SuggestedItemModel({this.imagePath, this.text});

  String get getImagePath => this.imagePath;

  set setImagePath(String imagePath) => this.imagePath = imagePath;

  get getText => this.text;

  set setText(text) => this.text = text;
}
