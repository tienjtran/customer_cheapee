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

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);
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
                  onPressed: () async {
                    final UserCredential userCredential =
                        await signInWithGoogle();
                    final User user = userCredential.user;
                    assert(user != null);
                    Navigator.pushNamed(context, NamedRoutes.homeRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
