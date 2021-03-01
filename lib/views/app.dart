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
        accentColor: AppColors.green2BAE68,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
