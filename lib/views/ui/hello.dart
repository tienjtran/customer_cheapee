import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.ac_unit,
        ),
        title: Text('Hello Screen'),
      ),
      body: Container(
        child: Container(
          alignment: Alignment.center,
          child: Text('Hello, World'),
        ),
      ),
    );
  }
}
