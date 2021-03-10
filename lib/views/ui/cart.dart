import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:customer_cheapee/views/utils/cart.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 1500000;
  String customerAddress = '14L Quốc Hương, phường Thảo Điền, quận 2';
  List<CartItemOutputModel> modelList = [
    CartItemOutputModel(
        'Sữa Milo',
        'https://www.zenmart.vn/Resources/Zenmart/Product/2020/02/2230/8934804034058-1-thung-sua-milo-it-duong-180ml-637181816727852931.jpg',
        300000,
        400000,
        5,
        1,
        true),
    CartItemOutputModel(
        'Thùng coca 24 lon',
        'https://product.hstatic.net/1000126467/product/thung_24_lon_nuoc_ngot_coca_cola_330ml.jpg',
        50000,
        300000,
        5,
        1,
        true),
    CartItemOutputModel(
        'Thùng mì gói hảo hảo',
        'https://tuoimart.vn/wp-content/uploads/2019/10/z1590737246700_fb4849deed1b275a9bcd032696c78e3d.jpg',
        300000,
        400000,
        5,
        1,
        true),
    CartItemOutputModel(
        'Thùng bia heineken',
        'https://csfood.vn/wp-content/uploads/2016/04/Bia-Heineken-Thung-1.jpg',
        300000,
        400000,
        5,
        1,
        true),
  ];

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
          Constants.cart,
          style: TextStyle(
            fontSize: AppFontSizes.largeSize,
            color: AppColors.strongGrey,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, right: 25, bottom: 10, left: 5),
              width: _contextWidth,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giao hàng đến'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: _contextWidth * 0.7,
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          customerAddress,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: AppFontSizes.size25,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          color: Color(0xff339ec9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.lightGrey,
              thickness: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider(
                      // indent: _contextWidth * 0.031,
                      // endIndent: _contextWidth * 0.031,
                      thickness: 1,
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
                    color: AppColors.lightGrey,
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
                            color: AppColors.strongGrey,
                            fontSize: AppFontSizes.largeSize,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(total),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: AppFontSizes.largeSize,
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
                          style: TextStyle(fontSize: AppFontSizes.largeSize),
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              content: Text(
                                  'Bạn có muốn đặt hàng những sản phẩm này?'),
                              actions: [
                                FlatButton(
                                  textColor: AppColors.strongGrey,
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text('Không'),
                                ),
                                FlatButton(
                                  textColor: AppColors.strongGreen,
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text('Đặt hàng'),
                                ),
                              ],
                            ),
                          );
                        },
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
