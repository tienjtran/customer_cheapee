import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:customer_cheapee/datasets/cart_view.dart';
import 'package:customer_cheapee/inputs/cart_view.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class CartViewModel {
  Future<CartDataset> loadingCart() async {
    var input = new LoadingCartInput();

    var storeId = FirebaseUtils.getStoreIdInCart();
    (await FirebaseUtils.getCartReference().get()).docs.forEach((e) {
      input.productList.add(int.parse(e.id));
    });
    input.storeId = await storeId;

    String mainUrl =
        FlutterConfig.get(ConfigKeyConstants.cheapeeApi) + APIUrls.loadCart;
    final response = await http.post(
      mainUrl,
      headers: {
        HttpHeaders.authorizationHeader:
            APIConstansts.bearerAuthorization.replaceFirst(
          APIConstansts.tokenParam,
          await FirebaseAuth.instance.currentUser.getIdToken(),
        ),
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(input),
    );
    final parsed = jsonDecode(response.body).cast<String, dynamic>();
    return CartDataset.fromJson(parsed);
  }

  Future<PlaceOrderDataset> placeOrder() async {
    User user = FirebaseAuth.instance.currentUser;
    var input = new PlaceOrderInput(
      email: user.email,
      uid: user.uid,
    );
    String mainUrl =
        FlutterConfig.get(ConfigKeyConstants.cheapeeApi) + APIUrls.placeOrder;
    final response = await http.post(
      mainUrl,
      headers: {
        HttpHeaders.authorizationHeader:
            APIConstansts.bearerAuthorization.replaceFirst(
          APIConstansts.tokenParam,
          await FirebaseAuth.instance.currentUser.getIdToken(),
        ),
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(input),
    );

    if (response.statusCode == 204) {
      return new PlaceOrderDataset(
        orderId: Constants.failedOrder,
      );
    }

    String body = response.body;
    final parsed = jsonDecode(body).cast<String, dynamic>();
    return PlaceOrderDataset.fromJson(parsed);
  }
}
