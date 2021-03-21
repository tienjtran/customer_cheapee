import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/ui/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';

class SuggestedProductWidget extends StatelessWidget {
  SuggestedProductWidget({Key key, this.model}) : super(key: key);
  final SuggestedProductModel model;

  void _navigateAndDisplaySelection(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
                productId: model.productId,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

    return Container(
      child: InkWell(
        onTap: () => _navigateAndDisplaySelection(context),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              width: contextWidth * 0.33,
              decoration: BoxDecoration(
                // border:
                //     Border.all(color: Color.fromRGBO(263, 263, 263, 0.2), width: 0.1),
                color: AppColors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 80,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(5),
                      //     ),
                      //     color: AppColors.lightGrey),
                      child: Image.network(
                        model.getImagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              model.getSalePrice,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 5),
                            child: Text(
                              model.getName,
                              style: TextStyle(
                                fontSize: 12.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
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
                    width: 45,
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
            ),
          ],
        ),
      ),
    );
  }
}
