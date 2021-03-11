import 'package:customer_cheapee/views/ui/cart.dart';
import 'package:customer_cheapee/views/ui/login.dart';
import 'package:customer_cheapee/views/ui/order.dart';
import 'package:customer_cheapee/views/ui/viewprofile.dart';
import 'package:customer_cheapee/views/ui/viewOrder.dart';
import 'package:customer_cheapee/views/ui/productDetail.dart';

import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';

class CustomerCheapee extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
              NamedRoutes.viewOrderRoute: (context) => ViewOrderScreen(),
              NamedRoutes.productDetailRoute: (context) =>
                  ProductDetailScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
