import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/models/output/home.dart';

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
