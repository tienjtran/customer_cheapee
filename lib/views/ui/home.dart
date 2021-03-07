import 'package:customer_cheapee/views/models/output/notification.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/profile.dart';
import 'package:customer_cheapee/views/utils/home.dart';
import 'package:customer_cheapee/views/utils/notification.dart';
import 'package:customer_cheapee/views/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/category.dart';
import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:customer_cheapee/views/ui/search.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double contextHeight;
  double contextWidth;
  static String positionSearch = '203 Đương Ngô Đình chiểu phường 7 quận 10';
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
        positionSearch,
        style: TextStyle(fontSize: AppFontSizes.largeSize),
      ),
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
          'https://nguoivietkhoedep.net/wp-content/uploads/2020/05/thitcatuoi_hhuu_thumb-300x291.jpg',
      text: 'Tươi sống',
    ),
    new SuggestedItemModel(
      imagePath:
          'https://media1.nguoiduatin.vn/media/nguyen-hoang-yen/2019/05/03/do-hop-ha-long.jpg',
      text: 'Đồ hộp',
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
  List<Store> storeList = [
    new Store(
      name: 'Bách hóa xanh Lê Văn Việt',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 1.1,
    ),
    Store(
      name: 'Vinmart Man Thiện',
      imagePath: 'https://cf.shopee.vn/file/270eae8e452c431ec9689d4deb109f1b',
      openTime: 480,
      closeTime: 1380,
      distance: 2.0,
    ),
    Store(
      name: 'Familymart khu công nghệ cao',
      imagePath: 'https://static.ybox.vn/2020/9/2/1599540305734-logo.jpg',
      openTime: 420,
      closeTime: 1440,
      distance: 3.1,
    ),
    Store(
      name: 'Bách hóa xanh xa lộ Hà Nội',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemBuilder: (context, i) {
        int listIndex = i - 4;
        if (listIndex > (storeList.length - 1)) {
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
            return buildNearStoreItem(listIndex, context);
        }
      },
    );
  }

  Widget buildNearStoreItem(int i, BuildContext context) {
    return NearStoreWidget(
      store: storeList[i],
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
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 35.0,
                color: AppColors.lightGrey,
                child: Row(
                  children: <Widget>[
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
