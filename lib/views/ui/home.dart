import 'package:customer_cheapee/models/store.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:customer_cheapee/views/utils/category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

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
        title: Text('203 Đương Ngô Đình chiểu phường 7 quận 10'),
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
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: 'Thông báo',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Tài khoản'),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        switch (i) {
          case 0:
            return SearchWidget();
          case 1:
            return SuggestedCategoryWidget();
          case 2:
            return _buildNearStoreText();
          default:
            return _buildNearStoreItem(i, context);
        }
      },
    );
  }

  Widget _buildNearStoreItem(int i, BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;

    if (i.isOdd)
      return Divider(
        indent: contextWidth * 0.031,
        endIndent: contextWidth * 0.031,
        thickness: 4.0,
      );
    else {
      return NearStoreWidget(
        store: Store(
          name: 'Bách hóa xanh',
          imagePath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyplPYVdltP8_FRwPc-_pSNypWo2Tynz7c1w&usqp=CAU',
          openTime: 450,
          closeTime: 1320,
          distance: 2.1,
        ),
      );
    }
  }

  Widget _buildNearStoreText() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Cửa hàng gần tôi",
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
            color: AppColors.greyECECEC,
            thickness: 3.0,
            endIndent: 200,
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(contextWidth * 0.042, contextHeight * 0.031,
          contextWidth * 0.042, contextHeight * 0.031),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: AppColors.greyF0F0F0,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 23.3,
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            iconSize: contextWidth * 0.1,
          )
        ],
      ),
    );
  }
}

class SuggestedCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;
    return Container(
        color: AppColors.green2BAE68,
        child: Center(
          child: Container(
              height: 210,
              width: contextWidth,
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
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                      NamingCategoryWidget(
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                      NamingCategoryWidget(
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NamingCategoryWidget(
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                      NamingCategoryWidget(
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                      NamingCategoryWidget(
                        imagePath: 'assets/images/coca.jpg',
                        text: Text('Nước ngọt'),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
