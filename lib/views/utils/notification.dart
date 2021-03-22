import 'package:customer_cheapee/views/models/output/notification.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({Key key, this.model}) : super(key: key);
  NotificationItemOutputModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Container(
            width: 30,
            child: Center(
              child: Icon(Icons.mail_outline),
            ),
          ),
          VerticalDivider(
            thickness: 2,
            color: AppColors.lightGrey,
            width: 30,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.status,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    model.content,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.strongGrey,
                    ),
                  ),
                  Text(model.time),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
