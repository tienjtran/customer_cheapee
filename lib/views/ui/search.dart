import 'package:customer_cheapee/views/utils/constants.dart';
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
  List<SearchResultOutputModel> dataResults = [
    SearchResultOutputModel(
      imagePath: 'https://cf.shopee.vn/file/11733ba78eb014870f11120d2674f22a',
      name: 'Thùng mì vị hương',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
    SearchResultOutputModel(
      imagePath:
          'https://salt.tikicdn.com/cache/w444/ts/product/54/09/ef/98bad22f6320b2ec3b6ee2b9e8254f02.jpg',
      name: 'Thùng mì hảo hảo',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
    SearchResultOutputModel(
      imagePath:
          'https://product.hstatic.net/1000288770/product/m__x_o_kh__h_o_h_o_t_m_chua_ng_t_g_i_th_ng_30_g_i_x_75_g_1024x1024.jpg',
      name: 'Thung Mì Thịt xào',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
    SearchResultOutputModel(
      imagePath:
          'https://csfood.vn/wp-content/uploads/2018/01/m%C3%AC-h%E1%BA%A3o-h%E1%BA%A3o-m%C3%AC-chay-h%C6%B0%C6%A1ng-v%E1%BB%8B-rau-n%E1%BA%A5m-th%C3%B9ng-30-g%C3%B3i.png',
      name: 'Thùng mì 3 miền',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
    SearchResultOutputModel(
      imagePath:
          'https://csfood.vn/wp-content/uploads/2017/12/th%C3%B9ng-m%C3%AC-g%C3%A0-t%C3%ADm-%C4%83n-li%E1%BB%81n-vifon.png',
      name: 'Thùng mì lẩu thái',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
    SearchResultOutputModel(
      imagePath: 'https://media3.scdn.vn/img2/2018/6_26/pjC6cb.jpg',
      name: 'Thùng mì đệ nhất',
      category: 'Đồ khô',
      daysLeft: 5,
      currentPrice: 120000,
      oldPrice: 80000,
      isLike: true,
    ),
  ];

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
            color: AppColors.lightGrey,
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
