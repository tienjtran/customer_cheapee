import 'package:customer_cheapee/views/utils/confirmOrder.dart';
import 'package:customer_cheapee/views/utils/orderHistory.dart';
import 'package:customer_cheapee/views/utils/waitForPayment.dart';
import 'package:customer_cheapee/views/utils/waitToCollect.dart';
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
            WaitToCollect(),
            WaitForPayment(),
            OrderHistory(),
          ],
        ),
      ),
    );
  }
}
