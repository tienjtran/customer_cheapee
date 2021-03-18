import 'package:customer_cheapee/presenters/search_presenter.dart';
import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SearchScreenDelegate extends SearchDelegate {
  SearchPresenter _searchPresenter = new SearchPresenter();
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

  Future<List<SearchResultOutputModel>> _getListModel() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await _searchPresenter.loadSearchScreen(
        position.latitude, position.longitude, 10, query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _getListModel(),
      builder: (BuildContext context,
          AsyncSnapshot<List<SearchResultOutputModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  SizedBox(
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.red,
                      size: 60,
                    ),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Rất tiếc không có kết quả bạn mong muốn.'),
                  )
                ],
              ),
            );
          } else {
            // * itemList builder
            return ListView.builder(
              itemBuilder: (context, i) {
                // * Divider at odd
                if (i.isOdd) {
                  return Divider(
                    thickness: 7,
                    color: AppColors.lightGrey,
                  );
                } else {
                  // * item at even
                  final index = i ~/ 2;
                  if (index >= snapshot.data.length) {
                    return null;
                  }
                  SearchResultOutputModel model = snapshot.data[index];
                  return SearchResultWidget(model);
                }
              },
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                SizedBox(
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColors.red,
                    size: 60,
                  ),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Rất tiếc đã có lỗi xảy ra.'),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Đang tìm kiếm...'),
                )
              ],
            ),
          );
        }
      },
    );
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

// class ResultSearchScreen extends StatefulWidget {
//   final itemList;
//   const ResultSearchScreen(this.itemList);
//   @override
//   _ResultSearchScreenState createState() => _ResultSearchScreenState();
// }

// class _ResultSearchScreenState extends State<ResultSearchScreen> {
// double _contextHeight;
// double _contextWidth;
// List<SearchResultOutputModel> _itemList = [
// SearchResultOutputModel(
//   SearchStore('Bách hóa xanh Lê Văn Việt', 3600, 3600, 3.2, 4.5,
//       'https://magiamgia247.vn/wp-content/uploads/2019/09/m%C3%A3-gi%E1%BA%A3m-gi%C3%A1-b%C3%A1ch-h%C3%B3a-xanh-1-1280x720.jpg'),
//   [
//     SearchItemModel(
//       'Thùng Pepsi 24 lon',
//       200000,
//       'https://lh3.googleusercontent.com/proxy/C29u6Zi2ZT2AMovG2n0eYQkqLZ2W5Ws7qEW9TvTfCSirRNxVgNy5XpooNc3KuLKjPoTIZM2VPqmrJjxA0_Xi8gDh4j4W5ylZqbuSaClcqEnrX_-TEWMy_e0assQm5QJOLA',
//     ),
//     SearchItemModel(
//       'Thùng coca 24 lon',
//       200000,
//       'https://sieuthitt.com/images/stories/virtuemart/product/cocaxuan.jpg',
//     ),
//   ],
// ),
// SearchResultOutputModel(
//   SearchStore('Vinmart Man Thiện', 3600, 3600, 3.2, 4.5,
//       'https://vincom.com.vn/sites/default/files/2016-10/VinMart_1.jpg'),
//   [],
// ),
// SearchResultOutputModel(
//   SearchStore('Familymart Trần Đức Tiến', 3600, 3600, 3.2, 4.5,
//       'https://www.midvalleysouthkey.com/img/tenant/logo-mobile05Apr2019171734.jpg'),
//   [
//     SearchItemModel(
//       'Thùng mirinda',
//       200000,
//       'https://vietgifts.com/wp-content/uploads/2019/01/mirinda-vi-cam-24-lon.jpg',
//     ),
//     SearchItemModel(
//       'Thùng 7up',
//       200000,
//       'https://img.websosanh.vn/v2/users/root_product/images/thung-nuoc-ngot-7up-chanh-12/JiXjLWqeYndD.jpg?compress=85',
//     ),
//     SearchItemModel(
//       'Thùng coca 24 lon',
//       200000,
//       'https://sieuthitt.com/images/stories/virtuemart/product/cocaxuan.jpg',
//     ),
//     SearchItemModel(
//       'Thùng pepsi 24 lon',
//       200000,
//       'https://cdn.tgdd.vn/Products/Images/2443/88121/bhx/24-lon-nuoc-ngot-pepsi-cola-330ml-201908201632500342.jpg',
//     ),
//   ],
// ),
// SearchResultOutputModel(
//   SearchStore('Bách hóa xanh Trần Bình Trọng', 3600, 3600, 3.2, 4.5,
//       'https://magiamgia247.vn/wp-content/uploads/2019/09/m%C3%A3-gi%E1%BA%A3m-gi%C3%A1-b%C3%A1ch-h%C3%B3a-xanh-1-1280x720.jpg'),
//   [
//     SearchItemModel(
//       'Thùng coca 24 lon',
//       200000,
//       'https://sieuthitt.com/images/stories/virtuemart/product/cocaxuan.jpg',
//     ),
//   ],
// ),
// SearchResultOutputModel(
//   SearchStore('Circle K FPT', 3600, 3600, 3.2, 4.5,
//       'https://assets1.csnews.com/files/styles/content_sm/s3/2020-03/Circle%20K%20Logo%20Sm_121317_1.png?itok=Yb6TJg38'),
//   [
//     SearchItemModel(
//       'Thùng mirinda',
//       200000,
//       'https://vietgifts.com/wp-content/uploads/2019/01/mirinda-vi-cam-24-lon.jpg',
//     ),
//     SearchItemModel(
//       'Thùng coca 24 lon',
//       200000,
//       'https://sieuthitt.com/images/stories/virtuemart/product/cocaxuan.jpg',
//     ),
//   ],
// ),
// ];

// @override
// void initState() {
//   super.initState();
// }

// @override
// Widget build(BuildContext context) {
//   _contextHeight = MediaQuery.of(context).size.height;
//   _contextWidth = MediaQuery.of(context).size.width;
//   return ListView.builder(
//     itemBuilder: (context, i) {
//       if (i.isOdd) {
//         return Divider(
//           thickness: 7,
//           color: AppColors.lightGrey,
//         );
//       } else {
//         final index = i ~/ 2;
//         if (index >= widget.itemList.length) {
//           return null;
//         }
//         SearchResultOutputModel model = _itemList[index];
//         return SearchResultWidget(model);
//       }
//     },
//   );
// }
// }
