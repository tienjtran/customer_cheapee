import 'dart:ui';

import 'package:customer_cheapee/presenters/productdetail_presenter.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailPresenter _productDetailPresenter =
      new ProductDetailPresenter();
  final int productId;

  ProductDetailScreen({this.productId});

  Future<ProductDetailModel> _getProductDetail(productInStoreId) async {
    return await _productDetailPresenter
        .loadProductDetailScreen(productInStoreId);
  }

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

    //danh sach cac san pham duoc goi y
    List<SuggestedProductModel> suggestedProductList = [
      new SuggestedProductModel(
        1,
        'Thùng Pepsi',
        'https://cdn.tgdd.vn/Products/Images/2443/88121/bhx/24-lon-nuoc-ngot-pepsi-cola-330ml-201908201632500342.jpg',
        20,
        'đ 200.000',
        'HSD còn 2 tháng',
        3,
        false,
      ),
      new SuggestedProductModel(
        1,
        'Nước Dasani 350ml',
        'https://cdn.tgdd.vn/Products/Images/2563/76400/bhx/nuoc-tinh-khiet-dasani-350ml-202002222041008058.jpg',
        30,
        'đ 10.000',
        'HSD còn 4 tháng',
        3,
        false,
      ),
      new SuggestedProductModel(
        1,
        'Thùng Pepsi không calo',
        'https://cdn.tgdd.vn/Products/Images/2443/227314/bhx/thung-24-lon-nuoc-ngot-pepsi-khong-calo-330ml-202008212036368424.jpg',
        40,
        'đ 180.000',
        'HSD còn 3 tháng',
        3,
        false,
      ),
      new SuggestedProductModel(
        1,
        'Thùng Mirinda 12 chai 1.5 lít',
        'https://cdn.tgdd.vn/Products/Images/2443/79142/bhx/thung-12-chai-nuoc-ngot-mirinda-vi-cam-15-lit-202003101727490978.jpg',
        50,
        'đ 180.000',
        'HSD còn 84 ngày',
        3,
        false,
      ),
      new SuggestedProductModel(
        1,
        'Thùng 7upa 12 chai 1.5 lít',
        'https://cdn.tgdd.vn/Products/Images/2443/86662/bhx/thung-12-chai-nuoc-ngot-7-up-vi-chanh-15-lit-202003101722023678.jpg',
        60,
        'đ 180.000',
        'HSD còn 3 tháng',
        3,
        false,
      ),
    ];

    void _onPressGoBack() {
      Navigator.pop(context);
    }

    bool _isDisabled(int remainingDays) {
      if (remainingDays >= 0) {
        return false;
      } else
        return true;
    }

    void displayBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Container(
              height: contextHeight * 0.35,
              width: contextWidth,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //TODO: Remaining product
                        Text('Kho: 215'),
                        Expanded(
                            child: Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.close_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () => _onPressGoBack(),
                          ),
                        ))
                      ],
                    ),
                    Divider(
                      color: AppColors.lightGrey,
                      thickness: 1.0,
                      indent: contextWidth * 0,
                      endIndent: contextWidth * 0,
                    ),
                    Row(children: [
                      Container(
                        height: contextHeight * 0.3 -
                            53 -
                            50, //53 cho phần trên, 50 cho button phía dưới
                        child: Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 250,
                              height: 30,
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30, right: 55),
                                  child: Text(
                                    Constants.quantity,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
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
                                      child: Icon(Icons.remove,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                Expanded(
                                  child: Container(
                                    color: AppColors.lightGrey,
                                    child: Center(
                                      child: TextFormField(
                                        initialValue: '1',
                                        keyboardType: TextInputType.number,
                                        textAlignVertical:
                                            TextAlignVertical.top,
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
                                  onTap: () {},
                                ),
                              ])),
                        )),
                      )
                    ]),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox.expand(
                              child: ElevatedButton(
                                child: Text(
                                  Constants.addToCart,
                                  style: TextStyle(
                                      fontSize: AppFontSizes.largeSize),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.5);
                                      return Theme.of(context).accentColor;
                                    },
                                  ),
                                ),
                                onPressed: () => {},
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
          });
    }

    Widget _productInfo(ProductDetailModel data) {
      return Container(
        padding:
            EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 0.0),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 7),
                  // * Name
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 7),
                  // * Brand
                  child: Text(
                    data.brandName,
                    style: TextStyle(
                        color: AppColors.strongGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          // * sale price
                          CommonUtils.convertDoubleToMoney(data.salePrice),
                          style: TextStyle(
                              color: AppColors.strongGreen,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Text(
                      // * price
                      CommonUtils.convertDoubleToMoney(data.originalPrice),
                      style: TextStyle(
                          color: AppColors.strongGrey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 17),
                    )
                  ],
                ),
                // * Ngày còn lại
                if (data.getRemainingDays > 0)
                  Container(
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    child: Text(
                      'Còn ' + data.getRemainingDays.toString() + ' ngày',
                      style: TextStyle(color: AppColors.red, fontSize: 17),
                    ),
                  )
                else if (data.getRemainingDays == 0)
                  Container(
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    child: Text(
                      'Còn hạn sử dụng trong ngày',
                      style: TextStyle(color: AppColors.red, fontSize: 17),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    child: Text(
                      'Đã hết hạn sử dụng',
                      style: TextStyle(color: AppColors.red, fontSize: 17),
                    ),
                  ),
                Container(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Text(
                      'Mô tả',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                Container(
                  child: Text(
                    data.description,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 0),
                  alignment: Alignment.center,
                  child: Text(
                    'Xem thêm',
                    style: TextStyle(
                      color: AppColors.strongGrey,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      );
    }

    // Widget productSuggestion = new Container(
    //   padding: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 15.0),
    //   child: Row(
    //     children: [
    //       Expanded(
    //           child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               'Sản phẩm liên quan',
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 13.5,
    //                   color: AppColors.strongGrey),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 210,
    //             child: ListView(
    //               scrollDirection: Axis.horizontal,
    //               children: <Widget>[
    //                 SuggestedProductWidget(model: suggestedProductList[0]),
    //                 SuggestedProductWidget(model: suggestedProductList[1]),
    //                 SuggestedProductWidget(model: suggestedProductList[2]),
    //                 SuggestedProductWidget(model: suggestedProductList[3]),
    //                 SuggestedProductWidget(model: suggestedProductList[4]),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ))
    //     ],
    //   ),
    // );

    return Scaffold(
      body: FutureBuilder(
        future: _getProductDetail(productId),
        builder:
            (BuildContext context, AsyncSnapshot<ProductDetailModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    SizedBox(
                      child: Icon(
                        Icons.cancel_outlined,
                        color: AppColors.red,
                        size: 60,
                      ),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Rất tiếc không có kết quả bạn mong muốn.'),
                    )
                  ],
                ),
              );
            } else {
              return Scaffold(
                  body: Stack(children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Image.network(
                              snapshot.data.imagePath,
                              width: contextWidth,
                              height: contextHeight * 0.3,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                            // * Product info
                            _productInfo(snapshot.data),
                            Divider(
                              color: AppColors.lightGrey,
                              thickness: 1.0,
                              indent: contextWidth * 0.031,
                              endIndent: contextWidth * 0.031,
                            ),
                            // * Product Suggestion
                            // productSuggestion,
                            //--------------------------------------------------------------------------
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                    child: Text(
                                      Constants.addToCart,
                                      style: TextStyle(
                                          fontSize: AppFontSizes.largeSize),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.5);
                                          else if (states
                                              .contains(MaterialState.disabled))
                                            return AppColors.lightGrey;
                                          return Theme.of(context).accentColor;
                                        },
                                      ),
                                    ),
                                    onPressed: _isDisabled(
                                            snapshot.data.getRemainingDays)
                                        ? null
                                        : () => displayBottomSheet(context)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: _onPressGoBack,
                      color: AppColors.white,
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ]));
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  SizedBox(
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.red,
                      size: 60,
                    ),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Rất tiếc đã có lỗi xảy ra.'),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Đang tải dữ liệu...'),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
