import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              Container(
                height: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chào mừng bạn đến với Cheapee',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: AppFontSizes.largeSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Đăng nhập để tiếp tục',
                      style: TextStyle(
                        color: AppColors.strongGrey,
                        fontSize: AppFontSizes.smallSize,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(
                  10,
                ),
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      NamedRoutes.homeRoute,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
