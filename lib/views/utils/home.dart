import 'package:flutter/material.dart';

class HomePromotionWidget extends StatelessWidget {
  String imagePath;

  HomePromotionWidget({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.network(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
