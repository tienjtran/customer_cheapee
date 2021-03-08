import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:customer_cheapee/views/models/output/product.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:flutter/material.dart';

List<String> _tabList = [
  'Chờ xác nhận',
  'Chờ lấy hàng',
  'Chờ thanh toán',
  'Lịch sử mua hàng',
];

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set initialIndex for DefaultTabController
    int index = ModalRoute.of(context).settings.arguments;
    if (index == null) {
      index = 0;
    }

    //Create _close method
    void _close() {
      Navigator.pop(context);
    }

    return DefaultTabController(
      length: 4,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => _close(),
            padding: const EdgeInsets.only(left: 20),
          ),
          title: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: _tabList[0],
              ),
              Tab(
                text: _tabList[1],
              ),
              Tab(
                text: _tabList[2],
              ),
              Tab(
                text: _tabList[3],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConfirmOrder(),
            Text(_tabList[1]),
            Text(_tabList[2]),
            Text(_tabList[3]),
          ],
        ),
      ),
    );
  }
}

class ConfirmOrder extends StatelessWidget {
  final List<OrderModel> orderModelList = [
    new OrderModel(
      'Bách hoá xanh Lã Xuân Oai',
      2,
      1000000,
      'assets/images/bachhoaxanh.jpg',
      new ProductModel(1, 'Thùng sữa Milo 24 lon', 600000, 400000, 3,
          'assets/images/milo.jpg'),
    ),
    new OrderModel(
      'GS 25 Lê Văn Việt',
      3,
      1800000,
      'assets/images/gs25.jpg',
      new ProductModel(2, 'Thùng nước ngọt Pepsi 24 lon', 600000, 400000, 4,
          'assets/images/pepsi.png'),
    ),
    new OrderModel(
      'GS 25 Lê Văn Việt',
      7,
      5500000,
      'assets/images/gs25.jpg',
      new ProductModel(2, 'Thùng nước ngọt Pepsi 24 lon', 600000, 400000, 7,
          'assets/images/pepsi.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _orderBuilder(orderModelList[0]),
          _orderBuilder(orderModelList[1]),
          _orderBuilder(orderModelList[2]),
        ],
      ),
    );
  }

  Widget _orderBuilder(OrderModel order) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              order.getImagePath,
              height: 20,
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(order.getName),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Image.asset(
                    order.product.imagePath,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.product.getName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(
                              order.product.getPrice),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          CommonUtils.convertDoubleToMoney(
                              order.product.getDiscountedPrice),
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          order.product.getRemainingDaysString + ' ngày',
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
              child: Text('x1'),
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
            Text(order.getQuantity.toString() + ' sản phẩm'),
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
