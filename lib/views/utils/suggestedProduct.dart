import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';

class SuggestedProductWidget extends StatelessWidget {
  SuggestedProductWidget({Key key, this.model}) : super(key: key);
  final SuggestedProductModel model;

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20,
            ),
            width: contextWidth * 0.4,
            height: contextWidth * 0.5,
            decoration: BoxDecoration(
              // border:
              //     Border.all(color: Color.fromRGBO(263, 263, 263, 0.2), width: 0.1),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 7,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    model.getImagePath,
                    fit: BoxFit.fill,
                    width: 75,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                          child: Text(
                            model.getName,
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
                            model.getSalePrice,
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
                            model.getExpiryDate,
                            style:
                                TextStyle(color: AppColors.red, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset(
                  'assets/images/sale_tag.png',
                  width: 42,
                ),
                Text(
                  '-${model.discount}%',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppFontSizes.smallSize,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
