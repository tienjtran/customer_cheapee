import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:customer_cheapee/views/models/output/product.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewOrderScreen extends StatefulWidget {
  @override
  _ViewOrderScreenState createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //receive model
    OrderModel _order = ModalRoute.of(context).settings.arguments;

    //Create _close method
    void _close(BuildContext context) {
      Navigator.pop(context);
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
                    Image.network(
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
                            'Hết hạn: ' + product.getRemainingDaysString,
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

    // * Order detail part
    Widget _buildOrderDetail(OrderModel order) {
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
                      Image.network(
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

    // * Bottom part
    Widget _buildBottomBar(OrderModel order) {
      void _cancelOrder(BuildContext context) {
        setState(() {
          order.process = 4;
        });
        Navigator.pop(context);
        return null;
      }

      void _showDialog(BuildContext context) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Xác nhận huỷ đơn hàng?'),
              actions: [
                FlatButton(
                  textColor: AppColors.black,
                  onPressed: () => _cancelOrder(context),
                  child: Text('Đồng ý'),
                ),
                FlatButton(
                  textColor: AppColors.red,
                  onPressed: () => _close(context),
                  child: Text('Không'),
                ),
              ],
            );
          },
        );
      }

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
                        onPressed: () => {}, // TODO: Add Copy
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
                    // * Order date
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thời gian đặt hàng'),
                      Text(DateFormat('yyyy-MM-dd hh:mm')
                          .format(order.getOrderDate)),
                    ],
                  ),
                  Row(
                    // * Confirm date
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thời gian xác nhận'),
                      Text(
                        order.confirmDate != null
                            ? DateFormat('yyyy-MM-dd hh:mm')
                                .format(order.getConfirmDate)
                            : '----------------------------',
                      ),
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
                    // * Cancel Order Button
                    height: 50,
                    minWidth: 150,
                    color: AppColors.red,
                    onPressed: order.process == Process.confirmOrder
                        ? () => _showDialog(context)
                        : null,
                    child: Text(order.process == Process.confirmOrder
                        ? 'Huỷ đơn hàng'
                        : order.process == Process.waitToCollect
                            ? 'Đã xác nhận\nĐang chờ lấy hàng'
                            : order.process == Process.waitForPayment
                                ? 'Đã xác nhận\nĐang chờ thanh toán'
                                : order.process == Process.orderHistory
                                    ? 'Đơn hàng đã thanh toán'
                                    : order.process == Process.canceled
                                        ? 'Đã bị huỷ'
                                        : 'Lỗi'),
                    textColor: AppColors.white,
                    disabledColor: AppColors.white,
                    disabledTextColor: order.process == Process.canceled
                        ? AppColors.red
                        : AppColors.strongGreen),
              ],
            ),
          ],
        ),
      );
    }

    // * Main body
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => _close(context),
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
                  _buildOrderDetail(_order),
                ],
              ),
            ),
            _buildBottomBar(_order),
          ],
        ),
      ),
    );
  }
}
