import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    'Tran Duc Tien',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Row(
                    // * Name
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Trần Đức Tiến',
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.strongGreen),
                            ),
                            prefix: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text('Họ Tên'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // * BirthDate
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '30/10/1999',
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.strongGreen),
                            ),
                            prefix: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text('Ngày sinh'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // * Address
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue:
                              '28 Trần Hưng Đạo, Phường 3, Quận 1, TP.HCM',
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.strongGreen),
                            ),
                            prefix: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text('Địa chỉ'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // * Email
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'tientd@fpt.edu.vn',
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: AppColors.strongGreen),
                            ),
                            prefix: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text('Email'),
                            ),
                          ),
                        ),
                      ),
                    ],
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
