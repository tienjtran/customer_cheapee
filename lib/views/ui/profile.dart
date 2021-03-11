import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _navigateToConfirmOrderScreen() {
      Navigator.pushNamed(context, NamedRoutes.orderRoute, arguments: 0);
    }

    void _navigateToWaitToCollectScreen() {
      Navigator.pushNamed(context, NamedRoutes.orderRoute, arguments: 1);
    }

    void _navigateToWaitForPaymentScreen() {
      Navigator.pushNamed(context, NamedRoutes.orderRoute, arguments: 2);
    }

    void _navigateToOrderHistoryScreen() {
      Navigator.pushNamed(context, NamedRoutes.orderRoute, arguments: 3);
    }

    void _navigateToViewProfileScreen() {
      Navigator.pushNamed(context, NamedRoutes.viewProfileRoute);
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.strongGreen,
                  radius: 40,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    FirebaseAuth.instance.currentUser.displayName,
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
                        Icons.timer_outlined,
                        color: AppColors.black,
                      ),
                      onPressed: _navigateToConfirmOrderScreen,
                      iconSize: 30,
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
                        color: AppColors.black,
                      ),
                      onPressed: _navigateToWaitToCollectScreen,
                      iconSize: 30,
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
                        color: AppColors.black,
                      ),
                      onPressed: _navigateToWaitForPaymentScreen,
                      iconSize: 30,
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
                        color: AppColors.black,
                      ),
                      onPressed: _navigateToOrderHistoryScreen,
                      iconSize: 30,
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
                  GestureDetector(
                    // * Tap to move to ViewProfile Screen
                    onTap: _navigateToViewProfileScreen,
                    child: Row(
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
                  ),
                  Divider(
                    color: AppColors.lightGrey,
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
                    color: AppColors.lightGrey,
                    endIndent: 50,
                  ),
                  InkWell(
                    child: Row(
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
                                color: AppColors.red,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Đăng xuất',
                                  style: TextStyle(
                                    color: AppColors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.red,
                        ),
                      ],
                    ),
                    onTap: () async {
                      await GoogleSignIn().signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          NamedRoutes.loginRoute, (route) => false);
                    },
                  ),
                  Divider(
                    color: AppColors.lightGrey,
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
