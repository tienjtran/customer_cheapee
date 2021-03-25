import 'package:customer_cheapee/presenters/consumer_presenter.dart';
import 'package:customer_cheapee/views/models/output/consumer.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ConsumerPresenter _consumerPresenter = new ConsumerPresenter();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: buildBody(context, email));
  }

  Future<ConsumerOutputModel> _getConsumerInfo(String email) async {
    return await _consumerPresenter.loadConsumerInfo(email);
  }

  @override
  Widget buildBody(BuildContext context, String email) {
    return FutureBuilder(
        future: _getConsumerInfo(email),
        builder: (BuildContext context,
            AsyncSnapshot<ConsumerOutputModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                                FirebaseAuth.instance.currentUser.photoURL)
                            .image,
                        onBackgroundImageError: (exception, stackTrace) {
                          print(exception);
                        },
                        radius: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          snapshot.data.name,
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
                                initialValue: snapshot.data.name,
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
                                    borderSide: BorderSide(
                                        color: AppColors.strongGreen),
                                  ),
                                  prefix: Container(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text('Họ Tên     '),
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
                                initialValue: snapshot.data.phone,
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
                                    borderSide: BorderSide(
                                        color: AppColors.strongGreen),
                                  ),
                                  prefix: Container(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text('Điện thoại'),
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
                                initialValue: snapshot.data.address,
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
                                    borderSide: BorderSide(
                                        color: AppColors.strongGreen),
                                  ),
                                  prefix: Container(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text('Địa chỉ     '),
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
                                initialValue: snapshot.data.email,
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
                                    borderSide: BorderSide(
                                        color: AppColors.strongGreen),
                                  ),
                                  prefix: Container(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text('Email       '),
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
            );
          } else {
            return Container();
          }
        });
  }
}
