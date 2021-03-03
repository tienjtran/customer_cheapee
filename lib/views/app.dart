import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'utils/constants.dart';

class CustomerCheapee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_TITLE,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: AppColors.GREEN_2BAE68,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
