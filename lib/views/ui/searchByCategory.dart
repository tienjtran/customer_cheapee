import 'package:customer_cheapee/presenters/search_presenter.dart';
import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SearchByCategoryScreen extends StatefulWidget {
  @override
  _SearchByCategoryScreenState createState() => _SearchByCategoryScreenState();
}

class _SearchByCategoryScreenState extends State<SearchByCategoryScreen> {
  SearchPresenter _searchPresenter = new SearchPresenter();

  String strResult;

  List<String> resultList = [];

  List<String> recenteList = ['Bò', 'gà'];

  List<String> suggestionList = [
    'Milk tea',
    'Milk trà đá',
    'Milk sâm bố bàu tử'
  ];

  void _onPressArrowBackIos() {
    Navigator.pop(context);
  }

  Future<List<SearchResultOutputModel>> _getListModel(String category) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await _searchPresenter.loadSearchByCategoryScreen(
        position.latitude, position.longitude, 10, category);
  }

  @override
  Widget buildBody(BuildContext context, String category) {
    return FutureBuilder(
      future: _getListModel(category),
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
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: new AppBar(
        title: Text(category),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _onPressArrowBackIos,
        ),
        elevation: 0.5,
      ),
      body: buildBody(context, category),
    );
  }
}
