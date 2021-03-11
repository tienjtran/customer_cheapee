import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:customer_cheapee/views/models/output/notification.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/profile.dart';
import 'package:customer_cheapee/views/ui/search.dart';
import 'package:customer_cheapee/views/utils/category.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/home.dart';
import 'package:customer_cheapee/views/utils/notification.dart';
import 'package:customer_cheapee/views/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position _currentPosition;
  static String _currentAddress = '';
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.thoroughfare}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }

  double contextHeight;
  double contextWidth;
  int quantity = 3;

  List<Widget> fragmentOptions = <Widget>[
    HomeFragment(),
    NotificationFragment(),
    ProfileScreen(),
  ];

  List<Widget> appbarOptions = <Widget>[
    AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.location_on_outlined,
          color: AppColors.black,
        ),
        iconSize: 20,
      ),
      title: Text(
        _currentAddress,
        style: TextStyle(fontSize: AppFontSizes.largeSize),
      ),
      elevation: 0,
    ),
    AppBar(
      title: Text('Thông báo'),
    ),
    null,
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int i) {
    setState(() {
      this._selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    contextHeight = MediaQuery.of(context).size.height;
    contextWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppbar(),
      body: buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _navigateToCartScreen,
              backgroundColor: AppColors.white,
              child: CartIconWidget(quantity),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  void _navigateToCartScreen() {
    Navigator.pushNamed(context, NamedRoutes.cartRoute);
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: HomeScreenConstant.homeLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: HomeScreenConstant.noticationLabel,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: HomeScreenConstant.accountLabel),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      onTap: _onItemTapped,
    );
  }

  Widget buildBody() {
    return fragmentOptions.elementAt(this._selectedIndex);
  }

  Widget buildAppbar() {
    return appbarOptions.elementAt(this._selectedIndex);
  }
}

class NotificationFragment extends StatelessWidget {
  NotificationFragment({Key key}) : super(key: key);

  List<NotificationItemOutputModel> modelList = List<
          NotificationItemOutputModel>.generate(
      10,
      (index) => new NotificationItemOutputModel(
          'Đơn hàng đã hoàn tất',
          'Đơn hàng tại bách hóa xanh Le văn việt đã hoàn tất cảm ơn các bạn đã chọn Cheapê cho hôm nay',
          '10 phút trước'));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
            );
          }
          int position = index ~/ 2;

          if (position >= modelList.length) {
            return null;
          }

          return NotificationItemWidget(
            model: modelList[position],
          );
        },
      ),
    );
  }
}

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<String> promotionImagePath = [
    'https://vuakhuyenmai.vn/wp-content/uploads/2021/01/vinmart-khuyen-mai-50off-5-1-2021.jpg',
    'https://www.bigc.vn/files/banners/2020/november/december/si-u-sale-1212-cover-blog-big-c.png',
    'https://cdn.tgdd.vn/Files/2020/05/19/1256620/tung-bung-khai-truong-sieu-thi-bach-hoa-xanh-online-tai-buon-ma-thuot-mua-hang-giam-gia-len-den-50-202005251049459813.png',
  ];
  String _result;
  double _contextHeight;
  double _contextWidth;
  List<SuggestedItemModel> suggestingItemList = [
    new SuggestedItemModel(
      imagePath: 'assets/images/vegetables.png',
      text: 'Rau củ',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/drinks.png',
      text: 'Giải khát',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/meats.png',
      text: 'Tươi sống',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/canned.png',
      text: 'Đồ hộp',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/snack.png',
      text: 'Bánh kẹo',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/fruits.png',
      text: 'Trái cây',
    ),
  ];

  List<NearStoreOutputModel> storeList = [
    NearStoreOutputModel(
      'Bách hóa xanh Bình Hưng Hòa',
      'https://magiamgia247.vn/wp-content/uploads/2019/09/m%C3%A3-gi%E1%BA%A3m-gi%C3%A1-b%C3%A1ch-h%C3%B3a-xanh-1-1280x720.jpg',
      2.1,
      [
        SuggestedProductModel(
            'Thùng mì hảo hảo',
            'https://vn-test-11.slatic.net/p/644d7ea90c85e4d2bee22275a4f26536.jpg_720x720q80.jpg_.webp',
            50,
            'đ 200.000',
            'HSD còn 2 tháng'),
        SuggestedProductModel(
            'Thùng mì omachi',
            'https://meta.vn/Data/image/2020/03/30/thung-30-goi-mi-omachi-xot-bo-ham-80gr-goi-sl.jpg',
            70,
            'đ 100.000',
            'HSD còn 4 tháng'),
        SuggestedProductModel(
            'Thùng mì 3 miền',
            'https://cdn.tgdd.vn/Products/Images/2565/80211/bhx/thung-30-goi-mi-3-mien-tom-chua-cay-65g-201912091512061369.jpg',
            80,
            'đ 180.000',
            'HSD còn 3 tháng'),
        SuggestedProductModel(
            'Thùng milo',
            'https://salt.tikicdn.com/cache/w1200/ts/product/d7/c8/f5/ec08dff519ca1b1c2f742ea837376ff1.jpg',
            70,
            'đ 180.000',
            'HSD còn 84 ngày'),
        SuggestedProductModel(
            'Thùng 7upa 12 chai 1.5 lít',
            'https://cdn.tgdd.vn/Products/Images/2443/86662/bhx/thung-12-chai-nuoc-ngot-7-up-vi-chanh-15-lit-202003101722023678.jpg',
            20,
            'đ 180.000',
            'HSD còn 3 tháng'),
      ],
    ),
    NearStoreOutputModel(
      'Vinmart Man Thiện',
      'https://isaac.vn/wp-content/uploads/2020/03/vinmart.01.jpg',
      2.1,
      [
        SuggestedProductModel(
            'Thùng Pepsi',
            'https://cdn.tgdd.vn/Products/Images/2443/88121/bhx/24-lon-nuoc-ngot-pepsi-cola-330ml-201908201632500342.jpg',
            50,
            'đ 200.000',
            'HSD còn 2 tháng'),
        SuggestedProductModel(
            'Nước Dasani 350ml',
            'https://cdn.tgdd.vn/Products/Images/2563/76400/bhx/nuoc-tinh-khiet-dasani-350ml-202002222041008058.jpg',
            70,
            'đ 10.000',
            'HSD còn 4 tháng'),
        SuggestedProductModel(
            'Thùng Pepsi không calo',
            'https://cdn.tgdd.vn/Products/Images/2443/227314/bhx/thung-24-lon-nuoc-ngot-pepsi-khong-calo-330ml-202008212036368424.jpg',
            80,
            'đ 180.000',
            'HSD còn 3 tháng'),
        SuggestedProductModel(
            'Thùng Mirinda 12 chai 1.5 lít',
            'https://cdn.tgdd.vn/Products/Images/2443/79142/bhx/thung-12-chai-nuoc-ngot-mirinda-vi-cam-15-lit-202003101727490978.jpg',
            70,
            'đ 180.000',
            'HSD còn 84 ngày'),
        SuggestedProductModel(
            'Thùng 7upa 12 chai 1.5 lít',
            'https://cdn.tgdd.vn/Products/Images/2443/86662/bhx/thung-12-chai-nuoc-ngot-7-up-vi-chanh-15-lit-202003101722023678.jpg',
            20,
            'đ 180.000',
            'HSD còn 3 tháng'),
      ],
    ),
    NearStoreOutputModel(
      'Circle K Man Thiện',
      'https://i1.wp.com/discountsandsavings.ca/wp-content/uploads/2020/08/Screenshot_20200805-205026_Chrome.jpg?resize=800%2C341&ssl=1',
      2.1,
      [
        SuggestedProductModel(
            'Thùng mì hảo hảo',
            'https://vn-test-11.slatic.net/p/644d7ea90c85e4d2bee22275a4f26536.jpg_720x720q80.jpg_.webp',
            50,
            'đ 200.000',
            'HSD còn 2 tháng'),
        SuggestedProductModel(
            'Thùng mì omachi',
            'https://meta.vn/Data/image/2020/03/30/thung-30-goi-mi-omachi-xot-bo-ham-80gr-goi-sl.jpg',
            70,
            'đ 100.000',
            'HSD còn 4 tháng'),
        SuggestedProductModel(
            'Thùng mì 3 miền',
            'https://cdn.tgdd.vn/Products/Images/2565/80211/bhx/thung-30-goi-mi-3-mien-tom-chua-cay-65g-201912091512061369.jpg',
            80,
            'đ 180.000',
            'HSD còn 3 tháng'),
        SuggestedProductModel(
            'Thùng milo',
            'https://salt.tikicdn.com/cache/w1200/ts/product/d7/c8/f5/ec08dff519ca1b1c2f742ea837376ff1.jpg',
            70,
            'đ 180.000',
            'HSD còn 84 ngày'),
        SuggestedProductModel(
            'Thùng 7upa 12 chai 1.5 lít',
            'https://cdn.tgdd.vn/Products/Images/2443/86662/bhx/thung-12-chai-nuoc-ngot-7-up-vi-chanh-15-lit-202003101722023678.jpg',
            20,
            'đ 180.000',
            'HSD còn 3 tháng'),
      ],
    ),
    NearStoreOutputModel(
      '7 Eleven FPT',
      'https://searchlogovector.com/wp-content/uploads/2018/05/7-eleven-logo-vector.png',
      2.1,
      [
        SuggestedProductModel(
            'Thùng mì hảo hảo',
            'https://vn-test-11.slatic.net/p/644d7ea90c85e4d2bee22275a4f26536.jpg_720x720q80.jpg_.webp',
            50,
            'đ 200.000',
            'HSD còn 2 tháng'),
        SuggestedProductModel(
            'Thùng mì omachi',
            'https://meta.vn/Data/image/2020/03/30/thung-30-goi-mi-omachi-xot-bo-ham-80gr-goi-sl.jpg',
            70,
            'đ 100.000',
            'HSD còn 4 tháng'),
        SuggestedProductModel(
            'Thùng mì 3 miền',
            'https://cdn.tgdd.vn/Products/Images/2565/80211/bhx/thung-30-goi-mi-3-mien-tom-chua-cay-65g-201912091512061369.jpg',
            80,
            'đ 180.000',
            'HSD còn 3 tháng'),
        SuggestedProductModel(
            'Thùng milo',
            'https://salt.tikicdn.com/cache/w1200/ts/product/d7/c8/f5/ec08dff519ca1b1c2f742ea837376ff1.jpg',
            70,
            'đ 180.000',
            'HSD còn 84 ngày'),
        SuggestedProductModel(
            'Thùng 7upa 12 chai 1.5 lít',
            'https://cdn.tgdd.vn/Products/Images/2443/86662/bhx/thung-12-chai-nuoc-ngot-7-up-vi-chanh-15-lit-202003101722023678.jpg',
            20,
            'đ 180.000',
            'HSD còn 3 tháng'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.white,
      child: ListView.builder(
        itemBuilder: (context, i) {
          int listIndex = i - 4;
          int realIndex = listIndex ~/ 2;
          if (realIndex > (storeList.length - 1)) {
            return null;
          }

          switch (i) {
            case 0:
              return buildSearchWidget(context);
            case 1:
              return buildPromotioncarousel(context);
            case 2:
              return buildSuggestedWidget(context);
            case 3:
              return buildNearStoreText(context);
            default:
              if (listIndex.isOdd) {
                return Divider(
                  indent: _contextHeight * 0.031,
                  endIndent: _contextWidth * 0.031,
                  thickness: 2,
                );
              }
              return buildNearStoreItem(realIndex, context);
          }
        },
      ),
    );
  }

  Widget buildNearStoreItem(int i, BuildContext context) {
    return NearStoreWidget(
      storeList[i],
    );
  }

  Widget buildNearStoreText(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                HomeScreenConstant.nearStoreText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSizes.largeSize),
              ),
              SizedBox(
                width: 15.0,
              ),
              Icon(
                Icons.storefront,
                size: 25,
              )
            ],
          ),
          Divider(
            color: AppColors.lightGrey,
            thickness: 3.0,
            endIndent: 200,
          ),
        ],
      ),
    );
  }

  Widget buildSearchWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: AppColors.lightGrey,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      size: 30.0,
                      color: AppColors.strongGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      HomeScreenConstant.searchEmptySentence,
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumSize,
                        color: AppColors.strongGrey,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                await showSearch(
                  context: context,
                  delegate: SearchScreenDelegate(),
                ).then((value) => setState(() {
                      _result = value;
                    }));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuggestedWidget(BuildContext context) {
    return Container(
        color: AppColors.strongGreen,
        child: Center(
          child: Container(
              height: 210,
              width: _contextWidth,
              margin: EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[0],
                      ),
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[1],
                      ),
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[2],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[3],
                      ),
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[4],
                      ),
                      NamingCategoryWidget(
                        outputModel: suggestingItemList[5],
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  Widget buildPromotioncarousel(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Container(
        margin: EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index < promotionImagePath.length) {
              return HomePromotionWidget(
                imagePath: promotionImagePath[index],
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}

class CartIconWidget extends StatelessWidget {
  CartIconWidget(this.quantity);

  int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              child: Icon(
                FlutterIcons.bag_sli,
                size: 35,
                color: AppColors.strongGrey,
              ),
              margin: EdgeInsets.all(
                5,
              ),
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                color: AppColors.lightGreen,
              ),
              child: Text(
                quantity.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: AppFontSizes.smallSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
