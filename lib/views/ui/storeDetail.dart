import 'package:customer_cheapee/presenters/storeDetail_presenter.dart';
import 'package:customer_cheapee/views/models/output/category.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/diamongShape.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:customer_cheapee/views/ui/home.dart';

class StoreDetailScreen extends StatelessWidget {
  StoreDetailPresenter _storeDetailPresenter = StoreDetailPresenter();

  // * Get storeModel from arguments

  @override
  Widget build(BuildContext context) {
    final int _storeId = ModalRoute.of(context).settings.arguments;
    asyncMethod(_storeId);
    loadListCategoryOnScreen();
    // * Get device size
    final _contextSize = MediaQuery.of(context).size;
    // * Navigators
    void _close() {
      Navigator.pop(context);
    }

    // * Create UI that contains all items in a specific category
    Widget _buildCategoryDetail(
      int category,
      String categoryName,
      List<SuggestedProductModel> productList,
    ) {
      return Scaffold(
        // * AppBar with Category name
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => _close(),
            padding: const EdgeInsets.only(left: 20),
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 70),
            child: Text(categoryName),
          ),
        ),
        // * Generate Product Grid
        body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            // ! Change this if GridView children overflow
            childAspectRatio: 0.6,
            children: [
              for (int i = 0; i < productList.length; i++)
                if (productList[i].getCategory == category)
                  SuggestedProductWidget(model: productList[i])
                else if (category == 0 && productList[i].getSuggested)
                  SuggestedProductWidget(model: productList[i])
            ],
          ),
        ),
      );
    }

    // * Select which product to display
    Widget _selectProduct(
      int category,
      SuggestedProductModel productModel,
    ) {
      if (category == 0 && productModel.getSuggested) {
        return SuggestedProductWidget(model: productModel);
      } else if (productModel.category == category) {
        return SuggestedProductWidget(model: productModel);
      } else {
        return SizedBox(
          child: null,
          height: 0,
        );
      }
    }

    // * Create UI that contains several Categories
    Widget _buildCategoryList(
        NearStoreOutputModel data, List<CategoryModel> _categoryList) {
      return ListView(
        children: [
          for (var i = 0; i < _categoryList.length; i++)
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // * Category Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            _categoryList[i].getImagePath,
                            width: 40,
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(_categoryList[i].getName),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _buildCategoryDetail(
                              _categoryList[i].categoryId,
                              _categoryList[i].getName,
                              data.productList,
                            ),
                          ),
                        ),
                        child: Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: AppColors.strongGreen,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  ),
                  // * Category Items
                  SizedBox(
                    height: 225,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index >= data.productList.length) {
                          return null;
                        }
                        return _selectProduct(_categoryList[i].categoryId,
                            data.productList[index]);
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      );
    }

    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 55.0),
          child: FloatingActionButton(
            onPressed: () => HomeScreenState.navigateToCartScreen(context),
            backgroundColor: AppColors.white,
            child: CartIconWidget(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: Future.wait(
                [asyncMethod(_storeId), loadListCategoryOnScreen()]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
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
                          child:
                              Text('Rất tiếc không có kết quả bạn mong muốn.'),
                        )
                      ],
                    ),
                  );
                } else {
                  return Scaffold(
                    // * Back button
                    floatingActionButton: Container(
                      child: FloatingActionButton(
                        onPressed: _close,
                        backgroundColor: AppColors.white,
                        shape: DiamondBorder(),
                        child: Container(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.startTop,
                    // * Body
                    body: Container(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          // * Big Image
                          Container(
                            child: Image.network(
                              snapshot.data[0].getImagePath,
                              width: _contextSize.width,
                              height: _contextSize.height * 0.2,
                            ),
                          ),
                          // * Store Detail
                          Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              children: [
                                // * Name
                                Text(
                                  snapshot.data[0].getStoreName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFontSizes.largeSize,
                                  ),
                                ),
                                // * Distant
                                Text(
                                  snapshot.data[0].distance.toString() + ' km',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                // * Operating Time
                                Text(CommonUtils.convertMinuteToStringTime(
                                        snapshot.data[0].openTime) +
                                    ' - ' +
                                    CommonUtils.convertMinuteToStringTime(
                                        snapshot.data[0].closeTime)),
                              ],
                            ),
                          ),
                          // * Category List
                          Expanded(
                            child: _buildCategoryList(
                                snapshot.data[0], snapshot.data[1]),
                          ),
                        ],
                      ),
                    ),
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
            }));
  }

  Future<NearStoreOutputModel> asyncMethod(int storeId) async {
    NearStoreOutputModel a;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    a = await _storeDetailPresenter.loadStoreDetailScreen(
        storeId, position.latitude, position.longitude, 5);
    return a;
  }

  Future<List<CategoryModel>> loadListCategoryOnScreen() async {
    List<CategoryModel> a;
    a = await _storeDetailPresenter.loadListCategory();
    return a;
  }
}
