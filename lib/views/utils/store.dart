import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';

class NearStoreWidget extends StatelessWidget {
  NearStoreOutputModel model;

  NearStoreWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        5,
      ),
      height: 200,
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                model.imagePath,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                model.storeName,
                style: TextStyle(
                  fontSize: AppFontSizes.mediumSize,
                ),
              ),
              Expanded(
                child: Text(
                  '<${model.distance}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumSize,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index >= model.productList.length) {
                  return null;
                }
                return SuggestedProductWidget(
                  model: model.productList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
