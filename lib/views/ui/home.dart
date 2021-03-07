import 'package:customer_cheapee/views/models/output/notification.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/profile.dart';
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
              child: CartIconWidget(),
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
  String _result = '';

  double _contextHeight;
  double _contextWidth;
  List<SuggestedItemModel> suggestingItemList = [
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
    new SuggestedItemModel(
      imagePath: 'assets/images/coca.jpg',
      text: 'Nước ngọt',
    ),
  ];
  List<Store> storeList = [
    new Store(
      name: 'Bách hóa xanh',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 2.1,
    ),
    Store(
      name: 'Bách hóa xanh',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 2.1,
    ),
    Store(
      name: 'Bách hóa xanh',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 2.1,
    ),
    Store(
      name: 'Bách hóa xanh',
      imagePath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
      openTime: 450,
      closeTime: 1320,
      distance: 2.1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemBuilder: (context, i) {
        int listIndex = i - 3;
        if (listIndex > (storeList.length - 1)) {
          return null;
        }

        switch (i) {
          case 0:
            return _buildSearchWidget(context);
          case 1:
            return _buildSuggestedWidget(context);
          case 2:
            return _buildNearStoreText(context);
          default:
            return _buildNearStoreItem(listIndex, context);
        }
      },
    );
  }

  Widget _buildNearStoreItem(int i, BuildContext context) {
    return NearStoreWidget(
      store: storeList[i],
    );
  }

  Widget _buildNearStoreText(context) {
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

  Widget _buildSearchWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          _contextWidth * 0.042,
          _contextHeight * 0.031,
          _contextWidth * 0.042,
          _contextHeight * 0.031),
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

  Widget _buildSuggestedWidget(BuildContext context) {
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
}

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({Key key}) : super(key: key);

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
                '2',
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
