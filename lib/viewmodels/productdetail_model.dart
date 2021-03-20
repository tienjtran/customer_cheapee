import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/product_dataset.dart';
import 'package:customer_cheapee/inputs/productdetail_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class ProductDetailViewModel {
  Future<ProductInStoreDataset> getProductDetail(
      ProductDetailInput input) async {
    String url = APIUrls.productDetailScreen;
    url = url.replaceFirst(APIUrls.pisId, input.id.toString());

    String mainUrl = FlutterConfig.get(ConfigKeyConstants.cheapeeApi) + url;
    final response = await http.get(
      mainUrl,
      headers: {
        HttpHeaders.authorizationHeader:
            APIConstansts.bearerAuthorization.replaceFirst(
          APIConstansts.tokenParam,
          await FirebaseAuth.instance.currentUser.getIdToken(),
        ),
      },
    );

    return parseDataFromJson(response.body);
  }

  ProductInStoreDataset parseDataFromJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    ProductInStoreDataset result = ProductInStoreDataset.fromJson(parsed);
    return result;
  }
}
