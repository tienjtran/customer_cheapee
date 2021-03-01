import 'package:flutter/material.dart';

class NamingCategoryWidget extends StatelessWidget {
  NamingCategoryWidget({Key key, this.imagePath, this.text}) : super(key: key);

  final String imagePath;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Image.asset(imagePath),
            iconSize: 50,
          ),
          text,
        ],
      ),
    );
  }
}
