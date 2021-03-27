import 'package:customer_cheapee/inputs/profile.dart';
import 'package:customer_cheapee/presenters/consumer_presenter.dart';
import 'package:customer_cheapee/presenters/updateProfile_presenter.dart';
import 'package:customer_cheapee/views/models/output/consumer.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

abstract class IUpdateView {
  void update(bool value);
}

class _ViewProfileScreenState extends State<ViewProfileScreen>
    implements IUpdateView {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneNumberController;
  TextEditingController addressController;
  bool upDateValue;
  UpdateProfilePresenter presenter;
  ConsumerPresenter _consumerPresenter;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    presenter = new UpdateProfilePresenter(this);
    _consumerPresenter = new ConsumerPresenter();
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
            nameController = TextEditingController(text: snapshot.data.name);
            emailController = TextEditingController(text: snapshot.data.email);
            phoneNumberController =
                TextEditingController(text: snapshot.data.phone);
            addressController =
                TextEditingController(text: snapshot.data.address);
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
                    child: Column(children: [
                      Row(
                        // * Name
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              controller: nameController,
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
                              controller: phoneNumberController,
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
                              controller: addressController,
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
                              enabled: false,
                              controller: emailController,
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
                                  child: Text('Email       '),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 40),
                            child: ElevatedButton(
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: AppFontSizes.largeSize,
                                    color: AppColors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.red)),
                              onPressed: () async {
                                try {
                                  await presenter.updateProfile(
                                    new ProfileUpdate(
                                      emailAddress: snapshot.data.getEmail,
                                      address: addressController.text,
                                      phoneNumber: phoneNumberController.text,
                                    ),
                                  );

                                  if (upDateValue) {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text('Thông báo'),
                                        content:
                                            Text('Bạn đã cập nhật thành công'),
                                        actions: [
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            'Có lỗi xảy ra với hệ thống :('),
                                        actions: [
                                          FlatButton(
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    ).then(
                                      (_) => Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            NamedRoutes.homeRoute),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  void update(bool result) {
    upDateValue = result;
  }
}
