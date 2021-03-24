import 'package:customer_cheapee/views/ui/cart.dart';
import 'package:customer_cheapee/views/ui/login.dart';
import 'package:customer_cheapee/views/ui/order.dart';
import 'package:customer_cheapee/views/ui/productDetail.dart';
import 'package:customer_cheapee/views/ui/searchByCategory.dart';
import 'package:customer_cheapee/views/ui/signup.dart';
import 'package:customer_cheapee/views/ui/storeDetail.dart';
import 'package:customer_cheapee/views/ui/viewOrder.dart';
import 'package:customer_cheapee/views/ui/viewprofile.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CustomerCheapee extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseMessaging messaging;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return null;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          setUpCloudMessaging();

          return MaterialApp(
            title: Constants.appTitle,
            theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: AppColors.strongGreen,
              cursorColor: AppColors.strongGreen,
            ),
            initialRoute: NamedRoutes.loginRoute,
            routes: {
              NamedRoutes.loginRoute: (context) => LoginScreen(),
              NamedRoutes.homeRoute: (context) => HomeScreen(),
              NamedRoutes.cartRoute: (context) => CartScreen(),
              NamedRoutes.orderRoute: (context) => OrderScreen(),
              NamedRoutes.viewProfileRoute: (context) => ViewProfileScreen(),
              NamedRoutes.viewOrderRoute: (context) => ViewOrderScreen(
                  orderId: ModalRoute.of(context).settings.arguments),
              NamedRoutes.productDetailRoute: (context) => ProductDetailScreen(
                    productId: ModalRoute.of(context).settings.arguments,
                  ),
              NamedRoutes.storeDetailRoute: (context) => StoreDetailScreen(),
              NamedRoutes.searchByCategory: (context) =>
                  SearchByCategoryScreen(),
              NamedRoutes.signUp: (context) => SignupScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }

  void setUpCloudMessaging() async {
    messaging = FirebaseMessaging.instance;
    String mess = await messaging.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
