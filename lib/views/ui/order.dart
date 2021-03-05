import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

List<String> _tabList = [
  'Chờ xác nhận',
  'Chờ lấy hàng',
  'Lịch sử mua hàng',
];

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _close() {
      Navigator.pop(context);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => _close(),
          ),
          bottom: TabBar(
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
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConfirmOrder(),
            Text(_tabList[1]),
            Text(_tabList[2]),
          ],
        ),
      ),
    );
  }
}

class ConfirmOrder extends StatelessWidget {
  List<OrderModel> orderModelList = [
    new OrderModel('Order 001', 2, 1000000, 'assets/images/bachhoaxanh.jpg'),
    new OrderModel('Order 002', 3, 1800000, 'assets/images/bachhoaxanh.jpg'),
    new OrderModel('Order 003', 7, 5500000, 'assets/images/bachhoaxanh.jpg'),
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
    MoneyFormatterOutput mfo = new FlutterMoneyFormatter(
        amount: order.getTotal,
        settings: MoneyFormatterSettings(
          symbol: 'đ',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
          fractionDigits: 0,
        )).output;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              order.getImagePath,
              height: 50,
              width: 50,
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(order.getName),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(order.getQuantity.toString() + ' sản phẩm'),
            Container(
              child: Row(
                children: [
                  Text('Tổng cộng: '),
                  Text(
                    mfo.symbolOnLeft,
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
          color: Color.fromRGBO(236, 236, 236, 100),
          thickness: 3,
        ),
      ],
    );
  }
}
