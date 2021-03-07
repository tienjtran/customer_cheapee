import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:flutter/services.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key key, this.model}) : super(key: key);
  CartItemOutputModel model;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  void onChangedCheckBox(bool value) {
    setState(() {
      this.widget.model.checked = value;
    });
  }

  void onPressedPlusSign() {
    setState(() {
      this.widget.model.quantity++;
    });
  }

  Widget buildYesNoDialog() {
    return AlertDialog(
      content: Text(Constants.beforeRemoveSentence),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            Constants.no,
            style: TextStyle(
              color: AppColors.strongGrey,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            Constants.accept,
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Theme.of(context).accentColor,
            ),
            child: Checkbox(
              value: this.widget.model.checked,
              onChanged: onChangedCheckBox,
              activeColor: Theme.of(context).accentColor,
              checkColor: AppColors.white,
            ),
          ),
          Image.asset(
            this.widget.model.imagePath,
            height: 60,
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.widget.model.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.mediumSize,
                  ),
                ),
                Text(
                  CommonUtils.convertDoubleToMoney(this.widget.model.oldPrice),
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: AppFontSizes.smallSize,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  CommonUtils.convertDoubleToMoney(
                      this.widget.model.currentPrice),
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: AppFontSizes.smallSize,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Còn ${this.widget.model.leftDays} ngày',
                  style: TextStyle(
                    fontSize: AppFontSizes.smallSize,
                    color: AppColors.strongGrey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 100,
              height: 30,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          topLeft: Radius.circular(7),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                      width: 30,
                      child: Center(
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (--this.widget.model.quantity == 0) {
                          showDialog(
                            context: context,
                            builder: (_) => buildYesNoDialog(),
                          );
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.lightGrey,
                      child: Center(
                        child: TextFormField(
                          key: Key(this.widget.model.quantity.toString()),
                          initialValue: this.widget.model.quantity.toString(),
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.top,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          style: TextStyle(
                            fontSize: AppFontSizes.largeSize,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                      width: 30,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    onTap: onPressedPlusSign,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
