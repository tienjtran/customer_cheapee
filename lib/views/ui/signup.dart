import 'package:customer_cheapee/inputs/sign_up_input.dart';
import 'package:customer_cheapee/presenters/sign_up_presenter.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

abstract class ISignUpView {
  void signUp(bool varlue);
}

class _State extends State<SignupScreen> implements ISignUpView {
  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController phoneNumberController;
  TextEditingController addressController;
  bool signUpValue;
  SignUpPresenter presenter;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    presenter = new SignUpPresenter(this);
    String name = ModalRoute.of(context).settings.arguments;
    nameController = TextEditingController(text: name);
    ageController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Sign up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Cheapee',
                  style: TextStyle(
                      color: AppColors.strongGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                enabled: false,
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Họ và Tên',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tuổi',
                ),
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Só điện thoại',
                ),
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Địa chỉ',
                ),
              ),
            ),
            FlatButton(
              textColor: AppColors.strongGreen,
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;
                try {
                  await presenter.signUp(
                    new SignUpInput(
                      emailAddress: user.email,
                      name: nameController.text,
                      address: addressController.text,
                      age: int.parse(ageController.text),
                      phoneNumber: phoneNumberController.text,
                    ),
                  );

                  if (signUpValue) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Thông báo'),
                        content: Text('Bạn đã đăng ký thành công'),
                        actions: [
                          FlatButton(
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                    await FirebaseMessaging.instance
                        .getToken()
                        .then((value) =>
                            FirebaseUtils.updateRegistrationToken(value))
                        .catchError((e) => print(e));
                    await FirebaseUtils.getSearchQueryRef();
                    Navigator.pushNamedAndRemoveUntil(
                        context, NamedRoutes.homeRoute, (route) => false);
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Error'),
                        content: Text('Có lỗi xảy ra với hệ thống :('),
                        actions: [
                          FlatButton(
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    ).then(
                      (_) => Navigator.of(context).popUntil(
                        ModalRoute.withName(NamedRoutes.homeRoute),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void signUp(bool result) {
    signUpValue = result;
  }
}
