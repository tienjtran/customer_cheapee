import 'package:customer_cheapee/views/ui/cart.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'utils/constants.dart';

class CustomerCheapee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: AppColors.GREEN_2BAE68,
        cursorColor: AppColors.GREEN_2BAE68,
      ),
      initialRoute: NamedRoutes.homeRoute,
      routes: {
        NamedRoutes.homeRoute: (context) => HomeScreen(),
        NamedRoutes.cartRoute: (context) => CartScreen(),
      },
    );
  }
}
