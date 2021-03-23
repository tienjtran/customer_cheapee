import 'package:customer_cheapee/presenters/cart_presenter.dart';
import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:customer_cheapee/views/utils/cart.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

abstract class ICartView {
  void loadingCart(CartOutputModel model);
  void loadingOrderDetail(int orderId);
}

class _CartScreenState extends State<CartScreen> implements ICartView {
  ICartPresenter _presenter;

  double total = 0;
  // String customerAddress = '14L Quốc Hương, phường Thảo Điền, quận 2';
  // String shopName = 'Bách hóa xanh bình hưng hòa';
  CartOutputModel model;

  @override
  void initState() {
    super.initState();

    _presenter = new CartPresenter(this);
    loadCartData();
  }

  void loadCartData() {
    model = new CartOutputModel(0, '', '');
    try {
      _presenter.loadCart();
    } catch (e) {
      print(e);
    }
  }

  // void _onPressZeroQuantity(CartItemOutputModel model) {
  //   setState(() {
  //     this.modelList.remove(model);
  //   });
  // }

  double _contextHeight;
  double _contextWidth;

  @override
  void loadingCart(CartOutputModel model) {
    setState(() {
      this.model = model;
    });
  }

  void _onPressArrowBackIos() {
    Navigator.pop(context);
  }

  void _countTotal() {
    total = 0;
    if (model != null) {
      model.productList.forEach((e) {
        total += (e.currentPrice * e.quantity);
      });
    }
  }

  void updateTotal() {
    setState(() {
      _countTotal();
    });
  }

  void delete(CartItemOutputModel model) {
    this.model.productList.remove(model);
    updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    _countTotal();
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
                  // Text('Cửa hàng'),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  Container(
                    width: _contextWidth * 0.7,
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      model.storeName,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: AppFontSizes.mediumSize,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: _contextWidth * 0.7,
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      model.storeAddress,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: AppFontSizes.largeSize,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //   Text(
                  //     'Chỉnh sửa',
                  //     style: TextStyle(
                  //       color: Color(0xff339ec9),
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ],
                  // ),
                ],
              ),
            ),
            Divider(
              color: AppColors.lightGrey,
              thickness: 5,
            ),
            (model.productList.length == 0)
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: FaIcon(
                            FontAwesomeIcons.dolly,
                            color: AppColors.strongGreen,
                            size: 80,
                          ),
                        ),
                        Text(
                          'Giỏ hàng trống',
                          style: TextStyle(
                            color: AppColors.strongGrey,
                          ),
                        ),
                      ],
                    ))
                : Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child:
                                ListView.builder(itemBuilder: (context, index) {
                              if (index >= model.productList.length) {
                                return null;
                              }
                              return CartItemWidget(
                                model: model.productList[index],
                                updateTotal: updateTotal,
                                delete: delete,
                              );
                            }),
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
                                        style: TextStyle(
                                            fontSize: AppFontSizes.largeSize),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.5);

                                            return Theme.of(context)
                                                .accentColor;
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
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                child: Text('Không'),
                                              ),
                                              FlatButton(
                                                textColor:
                                                    AppColors.strongGreen,
                                                onPressed: () {
                                                  // Navigator.of(context,
                                                  //         rootNavigator: true)
                                                  //     .pop();
                                                  _presenter.placeOrder();
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
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void loadingOrderDetail(int orderId) {
    String title;
    String content;
    Function eventOnpressed;
    ;
    if (orderId == Constants.failedOrder) {
      title = 'Đặt hàng thất bại';
      content =
          'Bạn đã đặt hàng thất bại, chúng tôi sẽ kiểm tra lại ngay, mong quý khách thông cảm!';

      eventOnpressed = () {
        Navigator.popUntil(
          context,
          ModalRoute.withName(NamedRoutes.homeRoute),
        );
      };
    } else {
      title = 'Đặt hàng thành công';
      content = 'Bạn đã đặt hàng thành công, đơn hàng của bạn đang được duyệt!';

      eventOnpressed = () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          NamedRoutes.viewOrderRoute,
          ModalRoute.withName(NamedRoutes.homeRoute),
          arguments: orderId.toString(),
        );
      };
    }
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
            onPressed: eventOnpressed,
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
