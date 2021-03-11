import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';
import 'package:flutter/material.dart';

class NearStoreWidget extends StatelessWidget {
  NearStoreOutputModel model;

  NearStoreWidget(this.model);

  @override
  Widget build(BuildContext context) {
    void _navigateToStoreDetailScreen() {
      Navigator.pushNamed(
        context,
        NamedRoutes.storeDetailRoute,
        arguments: model,
      );
    }

    return Container(
      margin: EdgeInsets.all(
        0,
      ),
      color: AppColors.white,
      height: 225,
      child: Column(
        children: [
          InkWell(
            onTap: _navigateToStoreDetailScreen,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Image.network(
                    model.imagePath,
                    height: 20,
                  ),
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
                    '${model.distance}km',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: SizedBox(
                height: 210,
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
            ),
          ),
        ],
      ),
    );
  }
}
