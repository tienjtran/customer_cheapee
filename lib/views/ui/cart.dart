import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/cart.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 1000000;
  String shopName = 'Bách hóa xanh bình hưng hòa';
  List<CartItemOutputModel> modelList =
      List<CartItemOutputModel>.generate(20, (index) {
    return new CartItemOutputModel('Sữa Milo ${index}',
        'assets/images/milo.jpg', 300000, 400000, 5, index + 1, true);
  });

  void _onPressZeroQuantity(CartItemOutputModel model) {
    setState(() {
      this.modelList.remove(model);
    });
  }

  double _contextHeight;
  double _contextWidth;

  void _onPressArrowBackIos() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _onPressArrowBackIos,
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: Constants.appBarFontSize,
            color: AppColors.GREY_424242,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              width: _contextWidth,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                shopName,
                style: TextStyle(
                  color: AppColors.GREY_424242,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider(
                      indent: _contextWidth * 0.031,
                      endIndent: _contextWidth * 0.031,
                      thickness: 2.5,
                    );
                  } else {
                    final position = index ~/ 2;
                    if (position >= modelList.length) {
                      return null;
                    }
                    return CartItemWidget(
                      model: modelList[position],
                    );
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.GREY_ADADAD,
                  ),
                ),
              ),
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: _contextWidth * 1.8 / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Constants.total + ': ',
                          style: TextStyle(
                            color: AppColors.GREY_424242,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(total),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox.expand(
                      child: ElevatedButton(
                        child: Text(
                          Constants.order,
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5);

                              return Theme.of(context).accentColor;
                            },
                          ),
                        ),
                        onPressed: () {},
                      ),
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
