import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchResultWidget extends StatelessWidget {
  SearchResultOutputModel model;

  SearchResultWidget(SearchResultOutputModel model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        5,
      ),
      child: Column(
        children: [
          StoreSearchWidget(model.store),
          Container(
            child: buildItemColumn(context),
          ),
        ],
      ),
    );
  }

  Widget buildItemColumn(BuildContext context) {
    List<SearchItemInStoreWidget> itemWidgetList = [];
    for (var item in model.itemList) {
      itemWidgetList.add(SearchItemInStoreWidget(item));
    }
    return Column(
      children: itemWidgetList,
    );
  }
}

class StoreSearchWidget extends StatelessWidget {
  SearchStore store;

  StoreSearchWidget(this.store);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        5,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  store.storeName,
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${CommonUtils.convertMinuteToStringTime(store.openingTime)}-${CommonUtils.convertMinuteToStringTime(store.closingTime)}',
                  style: TextStyle(
                    fontSize: AppFontSizes.smallSize,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${store.distance} km',
                      style: TextStyle(
                        fontSize: AppFontSizes.smallSize,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.fiber_manual_record,
                      size: 5,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rate,
                            size: 18,
                            color: AppColors.yellow,
                          ),
                          Text(
                            '${store.stars}',
                            style: TextStyle(
                              fontSize: AppFontSizes.smallSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  store.imagePath,
                  height: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchItemInStoreWidget extends StatelessWidget {
  SearchItemModel model;

  SearchItemInStoreWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
          ),
          Container(
            height: 37,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        model.itemName,
                        style: TextStyle(
                          fontSize: AppFontSizes.smallSize,
                        ),
                      ),
                      Text(
                        CommonUtils.convertDoubleToMoney(model.price),
                        style: TextStyle(
                          fontSize: AppFontSizes.smallSize,
                          color: AppColors.strongGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.network(
                    model.imagePath,
                    alignment: Alignment.centerRight,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
