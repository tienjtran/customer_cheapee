import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 40,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Tran Duc Tien',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Text('Order'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.clock,
                        color: Colors.black,
                      ),
                      onPressed: null,
                      iconSize: 50,
                    ),
                    Text(
                      'Chờ xác nhận',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.directions_bike_outlined,
                        color: Colors.black,
                      ),
                      onPressed: null,
                      iconSize: 50,
                    ),
                    Text(
                      'Chờ lấy hàng',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.black,
                      ),
                      onPressed: null,
                      iconSize: 50,
                    ),
                    Text(
                      'Chờ thanh toán',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.history,
                        color: Colors.black,
                      ),
                      onPressed: null,
                      iconSize: 50,
                    ),
                    Text(
                      'Lịch sử',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.sticky_note_2_outlined,
                              size: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Thông tin cá nhân'),
                            )
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(263, 263, 263, 0.2),
                    endIndent: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_border,
                              size: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Cửa hàng yêu thích'),
                            )
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(263, 263, 263, 0.2),
                    endIndent: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 30,
                              color: Colors.red,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(263, 263, 263, 0.2),
                    endIndent: 50,
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
