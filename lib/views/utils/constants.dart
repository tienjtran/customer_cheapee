import 'package:flutter/material.dart';

class AppColors {
  static const Color strongGreen = Color(0xff2bae68);

  static const Color lightGreen = Color(0xffc8e6c9);

  static const Color strongGrey = Color(0xff616161);

  static const Color lightGrey = Color(0xffE9ECF1);

  static const Color black = Colors.black;

  static const Color white = Colors.white;

  static const Color red = Colors.red;

  static const Color yellow = Colors.yellow;
}

class AppFontSizes {
  static const double smallSize = 12;
  static const double mediumSize = 15;
  static const double largeSize = 18;
  static const double size25 = 25;
}

class Constants {
  static const int failedOrder = -1;

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

  static const String total = 'Tổng';

  static const String addToCart = 'Thêm vào giỏ hàng';

  static const String quantity = 'Số lượng:';

  static const String filter = 'Bộ lọc tìm kiếm';
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

  static const String storeDetailRoute = '/storeDetail';

  static const String searchByCategory = '/searchByCategory';
}

class ConfigKeyConstants {
  static const String cheapeeApi = 'CHEAPEE_API_URL';
}

class APIUrls {
  static const String placeOrder = 'api/cart/place-an-order';

  static const String homeScreenCustomer =
      'api/homescreencustomer?latitude=${latitudeParam}&longitude=${longitudeParam}&distance=${distanceParam}';

  static const String latitudeParam = '{latitude}';

  static const String longitudeParam = '{longitude}';

  static const String distanceParam = '{distance}';

  static const String searchScreen =
      'api/searchscreen?latitude=${latitudeParam}&longitude=${longitudeParam}&distance=${distanceParam}&name=${searchName}';

  static const String searchByCategoryScreen =
      'api/searchbycategory?latitude=${latitudeParam}&longitude=${longitudeParam}&distance=${distanceParam}&category=${searchCategoryName}';

  static const String searchName = '{searchName}';

  static const String searchCategoryName = '{searchCategoryName}';

  static const String loadCart = 'api/cart/loading-cart';

  static const String productDetailScreen =
      'products-in-store/productdetail/$pisId';

  static const String pisId = '{pisId}';

  static const String getBrand = 'api/cheapee/brands/$brandId';

  static const String brandId = '{brandId}';

  static const String getManufacturer =
      'api/cheapee/manufacturers/$manufacturerId';

  static const String manufacturerId = '{manufacturerId}';

  static const String getPhoto = 'api/cheapee/photo/$photoId';

  static const String photoId = '{photoId}';

  static const String getAllOrder =
      'api/cheapee/orders/?search_email=$email&page_size=$pageSize&page_number=$pageNumber';

  static const String email = '{email}';

  static const String pageSize = '{pageSize}';

  static const String pageNumber = '{pageNumber}';

  // * Store
  static const String getStore = 'api/cheapee/store/idstore?storeId=$storeId';

  static const String storeId = '{storeId}';

  // * Order Detail
  static const String getAllOrderDetail =
      'api/cheapee/orderdetail?order_id=$orderId';

  static const String orderId = '{orderId}';

  static const String getAllCategory = 'api/cheapee/categories';

  // * Cancel Order
  static const String cancelOrder = 'api/cheapee/orders';

  // * Get Order
  static const String getOrder = 'api/cheapee/orders/$orderId';
}

class APIConstansts {
  static const String bearerAuthorization = 'Bearer ${tokenParam}';

  static const String tokenParam = '{token}';
}

class FirebaseConstants {
  static const String cartCollectionId = 'carts';

  static const String productField = 'products';

  static const String storeIdKey = 'store_id';

  static const String quantity = 'quantity';
}

class Process {
  static const int confirmOrder = 0;
  static const int waitToCollect = 1;
  static const int waitForPayment = 2;
  static const int orderHistory = 3;
  static const int canceled = 4;
}
