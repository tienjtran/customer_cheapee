import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/common.dart';

class NearStoreWidget extends StatelessWidget {
  final Store store;

  NearStoreWidget({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(17, 10, 17, 10),
      height: 80,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(
                store.imagePath,
                width: 59,
              ),
              Container(
                width: contextWidth * 0.05,
              ),
              Container(
                width: contextWidth * 0.5,
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      store.name,
                      style: CommonWidgetUtils.getCommonTextStyle(
                        fontSize: AppFontSizes.largeSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          Constants.kmDistance.replaceAll(
                              Constants.replaceNubmerVariable,
                              store.getDistance.toString()),
                          style: CommonWidgetUtils.getCommonTextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.strongGrey,
                            fontSize: AppFontSizes.smallSize,
                          ),
                        ),
                        Text(
                          '${CommonUtils.convertMinuteToStringTime(420)}-${CommonUtils.convertMinuteToStringTime(1320)}',
                          style: CommonWidgetUtils.getCommonTextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.strongGrey,
                            fontSize: AppFontSizes.smallSize,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Icon(
                    Icons.navigate_next,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
          Divider(
            indent: contextWidth * 0.031,
            endIndent: contextWidth * 0.031,
            thickness: 3.5,
          ),
        ],
      ),
    );
  }
}
