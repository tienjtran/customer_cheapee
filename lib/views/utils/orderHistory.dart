import 'package:customer_cheapee/presenters/order_presenter.dart';
import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatelessWidget {
  final OrderPresenter _orderPresenter = new OrderPresenter();
  final String email;

  OrderHistory({this.email});
  // final List<OrderModel> orderModelList = [
  //   new OrderModel(
  //     'DSF98H43KJH8HG2',
  //     'Bách hoá xanh Bình Hưng Hoà',
  //     1000000,
  //     'assets/images/bachhoaxanh.jpg',
  //     List<ProductModel>.from([
  //       new ProductModel(2, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(1, 'Thùng sữa Milo 24 lon', 600000, 400000, 3,
  //           'assets/images/milo.jpg'),
  //     ]),
  //     List<int>.from([1, 1]),
  //     new DateTime.utc(2021, 01, 26, 10, 59),
  //     new DateTime.utc(2021, 03, 01, 10, 59),
  //   ),
  //   new OrderModel(
  //     '9G84GKJGOI40APQ',
  //     'VinMart 127 Man Thiện',
  //     4800000,
  //     'assets/images/gs25.jpg',
  //     List<ProductModel>.from([
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(1, 'Thùng nước ngọt Pepsi 24 lon', 600000, 400000, 4,
  //           'assets/images/pepsi.png'),
  //       new ProductModel(2, 'Thùng sữa Milo 24 lon', 600000, 400000, 3,
  //           'assets/images/milo.jpg'),
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //       new ProductModel(3, 'Thùng trà ô long Tea+ 24 chai', 800000, 600000, 7,
  //           'assets/images/tea+.jpg'),
  //     ]),
  //     List<int>.from([1, 2, 1, 1, 1, 1, 1, 1]),
  //     new DateTime.utc(2021, 02, 20, 11, 59),
  //     new DateTime.utc(2021, 03, 01, 10, 59),
  //   ),
  //   new OrderModel(
  //     'FQ9438IAGHOIQ4H',
  //     'GS 25 Lê Văn Việt',
  //     1600000,
  //     'assets/images/gs25.jpg',
  //     List<ProductModel>.from([
  //       new ProductModel(1, 'Thùng nước ngọt Pepsi 24 lon', 600000, 400000, 4,
  //           'assets/images/pepsi.png'),
  //     ]),
  //     List<int>.from([4]),
  //     new DateTime.utc(2021, 01, 10, 16, 59),
  //     new DateTime.utc(2021, 03, 01, 10, 59),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    void _navigateToViewOrder(OrderModel orderModel) {
      Navigator.pushNamed(context, NamedRoutes.viewOrderRoute,
          arguments: orderModel.id);
    }

    return FutureBuilder(
      future: _orderPresenter.loadOrderScreen(this.email),
      builder:
          (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
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
                    child: Text('Không có đơn hàng trong lịch sử mua sắm.'),
                  )
                ],
              ),
            );
          } else {
            // * OrderList Builder
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  for (var o in snapshot.data)
                    if (o.process == Process.orderHistory ||
                        o.process == Process.canceled)
                      InkWell(
                        child: _orderBuilder(o),
                        onTap: () => _navigateToViewOrder(o),
                      ),
                ],
              ),
            );
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
                  child: Text('Đang xử lí...'),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _getTotalProductNumber(OrderModel orderModel) {
    int total = 0;
    for (var q in orderModel.quantityList) {
      total += q;
    }
    return Text(total.toString() + ' sản phẩm');
  }

  Widget _orderBuilder(OrderModel order) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              order.getImagePath,
              height: 30,
              width: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(order.getName),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Image.network(
                    order.productList[0].imagePath,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.productList[0].getName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(
                              order.productList[0].getPrice),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(
                              order.productList[0].getDiscountedPrice),
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Hết hạn: ' +
                              order.productList[0].getRemainingDaysString,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text('x' + order.quantityList[0].toString()),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[300],
          indent: 50,
          endIndent: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Hiển thị nhiều hơn',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getTotalProductNumber(order),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('Tổng cộng: '),
                  Text(
                    CommonUtils.convertDoubleToMoney(order.total),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Color.fromRGBO(236, 236, 236, 1),
          thickness: 3,
        ),
      ],
    );
  }
}
