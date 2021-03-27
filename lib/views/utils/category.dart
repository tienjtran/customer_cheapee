import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class NamingCategoryWidget extends StatefulWidget {
  NamingCategoryWidget({Key key, this.outputModel}) : super(key: key);
  final SuggestedItemModel outputModel;

  @override
  _NamingCategoryWidgetState createState() => _NamingCategoryWidgetState();
}

class _NamingCategoryWidgetState extends State<NamingCategoryWidget> {
  void _navigateToSearch() {
    Navigator.pushNamed(context, NamedRoutes.searchByCategory,
        arguments: widget.outputModel.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToSearch,
      child: Container(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Image.asset(widget.outputModel.getImagePath),
              iconSize: 50,
            ),
            Text(widget.outputModel.getText),
          ],
        ),
      ),
    );
  }
}

class StoreCategoryWidget extends StatelessWidget {
  StoreCategoryWidget({Key key, this.outputModel}) : super(key: key);
  final SuggestedItemModel outputModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Image.network(outputModel.getImagePath),
            iconSize: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(outputModel.getText),
          ),
        ],
      ),
    );
  }
}
