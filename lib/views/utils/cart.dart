import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key key, this.model, this.updateTotal, this.delete})
      : super(key: key);
  CartItemOutputModel model;
  Function updateTotal;
  Function delete;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  // void onChangedCheckBox(bool value) {
  //   setState(() {
  //     this.widget.model.checked = value;
  //   });
  // }

  void onPressedPlusSign() {
    setState(() {
      int value = ++this.widget.model.quantity;
      updateFireStoreInCart(value);
    });
  }

  Widget buildYesNoDialog() {
    return AlertDialog(
      content: Text(Constants.beforeRemoveSentence),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            setState(() {
              updateFireStoreInCart(++widget.model.quantity);
            });
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
            FirebaseUtils.getCartReference()
                .doc(widget.model.productId.toString())
                .delete();
            widget.delete(widget.model);
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
        color: AppColors.white,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                // Theme(
                //   data: ThemeData(
                //     unselectedWidgetColor: Theme.of(context).accentColor,
                //   ),
                //   child: Checkbox(
                //     value: this.widget.model.checked,
                //     onChanged: onChangedCheckBox,
                //     activeColor: Theme.of(context).accentColor,
                //     checkColor: AppColors.white,
                //   ),
                // ),
                Image.network(
                  this.widget.model.imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.widget.model.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSizes.mediumSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        CommonUtils.convertDoubleToMoney(
                            this.widget.model.oldPrice),
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
                              int value = --this.widget.model.quantity;
                              updateFireStoreInCart(value);
                              if (value == 0) {
                                showDialog(
                                  context: context,
                                  builder: (_) => buildYesNoDialog(),
                                  barrierDismissible: false,
                                );
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Container(
                            color: AppColors.white,
                            child: Center(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  if (value.isEmpty) {
                                    setState(() {});
                                    return false;
                                  } else {
                                    int numValue = int.parse(value);
                                    widget.model.quantity = numValue;
                                    updateFireStoreInCart(numValue);
                                  }
                                },
                                key: Key(this.widget.model.quantity.toString()),
                                initialValue:
                                    this.widget.model.quantity.toString(),
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.top,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
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
            Divider(
              // indent: _contextWidth * 0.031,
              // endIndent: _contextWidth * 0.031,
              thickness: 1,
            ),
          ],
        ));
  }

  void updateFireStoreInCart(int value) {
    FirebaseUtils.getCartReference()
        .doc(widget.model.productId.toString())
        .update({FirebaseConstants.quantity: value});
    widget.updateTotal();
  }
}
