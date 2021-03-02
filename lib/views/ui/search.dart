import 'package:flutter/material.dart';

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
    strResult = query;
    Navigator.pop(context, strResult);
    return Container();
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
            Navigator.pop(context, strResult);
          },
        );
      },
    );
  }
}
