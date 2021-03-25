import 'package:customer_cheapee/presenters/signin_presenter.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

abstract class ILoginScreen {
  void setUserStatus(bool value);
}

class LoginScreen extends StatelessWidget implements ILoginScreen {
  bool _isValidUser;
  ISignInPresenter presenter;

  LoginScreen({Key key}) : super(key: key) {
    presenter = new SignInPresenter(this);
  }
  void permission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    permission();
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
                  padding: EdgeInsets.all(2.0),
                  elevation: 10.0,
                  onPressed: () {
                    login(context).catchError((e) => {print(e)});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(BuildContext context) async {
    UserCredential credential;
    await signInWithGoogle()
        .then((userCredential) => credential = userCredential)
        .catchError((_) => {});
    if (credential != null) {
      await presenter.checkExists();
      if (_isValidUser) {
        await FirebaseMessaging.instance
            .getToken()
            .then((value) => FirebaseUtils.updateRegistrationToken(value))
            .catchError((e) => print(e));
        Navigator.of(context).pushNamedAndRemoveUntil(
            NamedRoutes.homeRoute, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamed(NamedRoutes.signUp,
            arguments: FirebaseAuth.instance.currentUser.displayName);
      }
    }
  }

  @override
  void setUserStatus(bool value) {
    _isValidUser = value;
  }
}
