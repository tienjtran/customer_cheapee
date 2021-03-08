import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:customer_cheapee/views/models/output/product.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //receive model
    OrderModel order = ModalRoute.of(context).settings.arguments;

    //Create _close method
    void _close() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => _close(),
          padding: const EdgeInsets.only(left: 20),
        ),
        title: Text('Thông tin đơn hàng'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //All order
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  _orderDetailBuilder(order),
                ],
              ),
            ),
            _buildBottomBar(order),
          ],
        ),
      ),
    );
  }
}

Widget _orderDetailBuilder(OrderModel order) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Container(
          child: Column(
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
              _buildProductList(
                  order.productList, order.quantityList), // * Product list
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildProductRow(ProductModel product, int quantity) {
  return Column(
    children: [
      Divider(
        color: Colors.grey[300],
        indent: 50,
        endIndent: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Image.asset(
                  product.imagePath,
                  height: 70,
                  width: 70,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.getName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        CommonUtils.convertDoubleToMoney(product.getPrice),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        CommonUtils.convertDoubleToMoney(
                            product.getDiscountedPrice),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        product.getRemainingDaysString + ' ngày',
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
            child: Text('x' + quantity.toString()),
          ),
        ],
      ),
    ],
  );
}

Widget _buildProductList(
    List<ProductModel> productList, List<int> quantityList) {
  return Container(
    child: Column(
      children: [
        for (int i = 0; i < productList.length; i++)
          _buildProductRow(productList[i], quantityList[i])
      ],
    ),
  );
}

Widget _buildBottomBar(OrderModel order) {
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            // * info
            children: [
              Row(
                // * order code
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mã đơn hàng'),
                      Text(
                        order.getId,
                        style: TextStyle(
                          color: AppColors.strongGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    // * button Copy
                    child: Text(
                      'Copy',
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                    onPressed: () => {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // * order date
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thời gian đặt hàng'),
                  Text(DateFormat('yyyy-MM-dd hh:mm')
                      .format(order.getOrderDate)),
                ],
              ),
              Row(
                // * confirm date
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thời gian xác nhận'),
                  Text('----------------------------'),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lightGrey,
                  ),
                ),
                child: Row(
                  children: [
                    Text('Tổng: '),
                    Text(
                      CommonUtils.convertDoubleToMoney(order.total),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
              height: 50,
              minWidth: 150,
              color: AppColors.red,
              onPressed: () => {},
              child: Text(
                'Huỷ đơn hàng',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
