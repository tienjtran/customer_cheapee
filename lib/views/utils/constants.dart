import 'package:flutter/material.dart';

class AppColors {
  static const Color strongGreen = Color(0xff2bae68);

  static const Color lightGreen = Color(0xffc8e6c9);

  static const Color strongGrey = Color(0xff616161);

  static const Color lightGrey = Color(0xffd6d6d6);

  static const Color black = Colors.black;

  static const Color white = Colors.white;

  static const Color red = Colors.red;
}

class AppFontSizes {
  static const double smallSize = 12;
  static const double mediumSize = 15;
  static const double largeSize = 18;
}

class Constants {
  static const String cart = 'Giỏ hàng';

  static const String appTitle = "Cheappe";

  static const String kmDistance = "{number} km";

  static const String replaceNubmerVariable = '{number}';

  static const int sixtyMinutes = 60;

  static const String usRegion = 'en_US';

  static const String integerNumberPattern = "###,000";

  static const String no = 'Không';

  static const String accept = 'Đồng ý';

  static const String beforeRemoveSentence =
      'Bạn có chắc muốn bỏ sản phẩm này?';

  static const String order = 'Đặt hàng';

  static const String total = 'Tổng tiền';

  static const String addToCart = 'Thêm vào giỏ hàng';

  static const String quantity = 'Số lượng:';
}

class HomeScreenConstant {
  static const String homeLabel = 'Trang chủ';

  static const String noticationLabel = 'Thông báo';

  static const String accountLabel = 'Tài khoản';

  static const String nearStoreText = 'Cửa hàng gần tôi';

  static const String searchEmptySentence = 'Bạn đang muốn mua gì?';
}

class NamedRoutes {
  static const String cartRoute = '/cart';

  static const String homeRoute = '/';

  static const String orderRoute = '/order';

  static const String loginRoute = '/login';

  static const String productDetailRoute = '/productDetail';

  static const String viewProfileRoute = '/viewProfile';
  static const String viewOrderRoute = '/viewOrder';
}
