import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/category.dart';
import 'package:customer_cheapee/views/models/output/home.dart';
import 'package:customer_cheapee/views/ui/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double contextHeight;
  double contextWidth;
  String positionSearch = '203 Đương Ngô Đình chiểu phường 7 quận 10';

  static const List<Widget> _fragmentOptions = <Widget>[
    HomeFragment(),
    Text(
      'Index 1: Notification',
    ),
    Text(
      'Index 2: Account',
    ),
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
      appBar: AppBar(
        toolbarHeight: contextHeight * 0.083,
        leading: IconButton(
          icon: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
          iconSize: 30.0,
        ),
        title: Text(positionSearch),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: HomeScreenConstant.HOME_LABEL,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: HomeScreenConstant.NOTIFICATION_LABEL,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: HomeScreenConstant.ACCOUNT_LABEL),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      onTap: _onItemTapped,
    );
  }

  Widget _buildBody() {
    return _fragmentOptions.elementAt(this._selectedIndex);
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
                HomeScreenConstant.NEAR_STORE_TEXT,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
            color: AppColors.GREY_ECECEC,
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
                color: AppColors.GREY_F0F0F0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      (_result?.isEmpty ?? true)
                          ? HomeScreenConstant.SEARCH_EMPTY_SENTENCE
                          : _result,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ((_result?.isEmpty ?? true)
                            ? Colors.grey
                            : Colors.black),
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
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            iconSize: _contextWidth * 0.1,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildSuggestedWidget(BuildContext context) {
    return Container(
        color: AppColors.GREEN_2BAE68,
        child: Center(
          child: Container(
              height: 210,
              width: _contextWidth,
              margin: EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: Colors.white,
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
