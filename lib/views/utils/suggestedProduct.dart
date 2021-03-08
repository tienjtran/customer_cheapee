import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';

class SuggestedProductWidget extends StatelessWidget {
  SuggestedProductWidget({Key key, this.suggestedProductModel})
      : super(key: key);
  final SuggestedProductModel suggestedProductModel;

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

    return Container(
      width: contextWidth * 0.3,
      height: contextWidth * 0.3,
      decoration: BoxDecoration(
        // border:
        //     Border.all(color: Color.fromRGBO(263, 263, 263, 0.2), width: 0.1),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              suggestedProductModel.getImagePath,
              fit: BoxFit.fill,
              width: contextWidth * 0.3 - 1,
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
              child: Text(
                suggestedProductModel.getName,
                style: TextStyle(
                  fontSize: 13.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5, left: 5),
              child: Text(
                suggestedProductModel.getSalePrice,
                style: TextStyle(
                  color: AppColors.strongGreen,
                  fontSize: 13.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                suggestedProductModel.getExpiryDate,
                style: TextStyle(color: AppColors.red, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
