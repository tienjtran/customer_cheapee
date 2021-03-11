import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:flutter/material.dart';

class NamingCategoryWidget extends StatelessWidget {
  NamingCategoryWidget({Key key, this.outputModel}) : super(key: key);
  final SuggestedItemModel outputModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Image.asset(outputModel.getImagePath),
            iconSize: 50,
          ),
          Text(outputModel.getText),
        ],
      ),
    );
  }
}

class StoreCategoryWidget extends StatelessWidget {
  StoreCategoryWidget({Key key, this.outputModel}) : super(key: key);
  final SuggestedItemModel outputModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Image.network(outputModel.getImagePath),
            iconSize: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(outputModel.getText),
          ),
        ],
      ),
    );
  }
}
