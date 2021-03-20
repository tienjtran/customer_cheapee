import 'package:customer_cheapee/presenters/storeDetail_presenter.dart';
import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/diamongShape.dart';
import 'package:customer_cheapee/views/utils/suggestedProduct.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StoreDetailScreen extends StatelessWidget {
  StoreDetailPresenter _storeDetailPresenter = StoreDetailPresenter();

  // * Get storeModel from arguments
  final List<SuggestedItemModel> _categoryList = [
    new SuggestedItemModel(
      imagePath:
          'https://media.istockphoto.com/vectors/banana-with-thumbs-up-vector-id525671293?k=6&m=525671293&s=170667a&w=0&h=N-51OhS_46AiltZediBHJyPl671PDvUwe04XKdVobN4=',
      text: 'Gợi ý cho bạn',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://43s0w3yikyo2qsm4r33qc6d7-wpengine.netdna-ssl.com/wp-content/uploads/2017/01/meat_PNG3902.png',
      text: 'Thịt cá',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://photosfine.files.wordpress.com/2012/04/white-background-fruit-and-vegetables-2.jpg',
      text: 'Rau củ',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://bizweb.dktcdn.net/thumb/1024x1024/100/391/207/products/500mlrevive.jpg?v=1606706069087',
      text: 'Giải khát',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://media1.nguoiduatin.vn/media/nguyen-hoang-yen/2019/05/03/do-hop-ha-long.jpg',
      text: 'Thực phẩm chế biến sẵn',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://shelbyreport.nyc3.cdn.digitaloceanspaces.com/wp-content/uploads/2018/08/PRO-SNICKERS.jpg',
      text: 'Bánh kẹo',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://anh.eva.vn/upload/3-2018/images/2018-08-03/an-qua-nhieu-trai-cay-khong-tot-nhung-an-5-loai-qua-nay-cang-nhieu-cang-tot-cho-suc-khoe-trai-cay1-15331132143471276157929-1533265891-782-width600height450.jpg',
      text: 'Trái cây',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int _storeId = ModalRoute.of(context).settings.arguments;
    asyncMethod(_storeId);
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
      } else if (productModel.getCategory == category) {
        return SuggestedProductWidget(model: productModel);
      } else {
        return Container(child: null);
      }
    }

    // * Create UI that contains several Categories
    Widget _buildCategoryList(NearStoreOutputModel data) {
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
                            child: Text(_categoryList[i].getText),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _buildCategoryDetail(
                              i,
                              _categoryList[i].getText,
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
                        return _selectProduct(i, data.productList[index]);
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
        body: FutureBuilder(
            future: asyncMethod(_storeId),
            builder: (BuildContext context,
                AsyncSnapshot<NearStoreOutputModel> snapshot) {
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
                              snapshot.data.getImagePath,
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
                                  snapshot.data.getStoreName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFontSizes.largeSize,
                                  ),
                                ),
                                // * Distant
                                Text(
                                  snapshot.data.distance.toString() + ' km',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                // * Operating Time
                                Text(CommonUtils.convertMinuteToStringTime(
                                        snapshot.data.openTime) +
                                    ' - ' +
                                    CommonUtils.convertMinuteToStringTime(
                                        snapshot.data.closeTime)),
                              ],
                            ),
                          ),
                          // * Category List
                          Expanded(
                            child: _buildCategoryList(snapshot.data),
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
}
