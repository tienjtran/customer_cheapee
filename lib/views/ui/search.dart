import 'package:customer_cheapee/views/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/models/output/search.dart';

class SearchScreenDelegate extends SearchDelegate {
  String strResult;
  List<String> resultList = [];
  List<String> recenteList = ['Bò', 'gà'];
  List<String> suggestionList = [
    'Milk tea',
    'Milk trà đá',
    'Milk sâm bố bàu tử'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultSearchScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    query.isEmpty ? resultList = recenteList : resultList = suggestionList;
    return ListView.builder(
      itemCount: resultList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(query.isEmpty ? Icons.schedule : null),
          title: Text(
            resultList[index],
          ),
          onTap: () {
            strResult = resultList[index];
            query = strResult;
            showResults(context);
          },
        );
      },
    );
  }
}

class ResultSearchScreen extends StatefulWidget {
  @override
  _ResultSearchScreenState createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  double _contextHeight;
  double _contextWidth;
  List<SearchResultOutputModel> dataResults =
      List<SearchResultOutputModel>.generate(10, (index) {
    return new SearchResultOutputModel(
      imagePath: 'assets/images/rau-ma.jpg',
      name: 'Rau chân vịt ${index}',
      category: 'Thức ăn',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    );
  });

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider(
            indent: _contextHeight * 0.031,
            endIndent: _contextWidth * 0.031,
            thickness: 2.5,
          );
        } else {
          final index = i ~/ 2;
          if (index >= dataResults.length) {
            return null;
          }
          SearchResultOutputModel model = dataResults[index];
          return SearchResultItemWidget(model);
        }
      },
    );
  }
}
