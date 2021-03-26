import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';
import 'package:flutter/material.dart';

class NearStoreWidget extends StatelessWidget {
  double _contextWidth;
  NearStoreOutputModel model;

  NearStoreWidget(this.model);

  @override
  Widget build(BuildContext context) {
    void _navigateToStoreDetailScreen() {
      Navigator.pushNamed(
        context,
        NamedRoutes.storeDetailRoute,
        arguments: model.storeId,
      );
    }

    _contextWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(
        0,
      ),
      color: AppColors.white,
      height: 251,
      child: Column(
        children: [
          InkWell(
            onTap: _navigateToStoreDetailScreen,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      model.imagePath,
                      height: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: _contextWidth * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.storeName,
                        style: TextStyle(
                            fontSize: AppFontSizes.largeSize,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model.distance} km',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.strongGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.strongGrey,
                  ),
                  iconSize: 16,
                )),
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
