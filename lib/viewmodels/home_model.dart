import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:customer_cheapee/datasets/home_view.dart';
import 'package:customer_cheapee/inputs/home_view.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel {
  Future<List<ProductInNearStoreDataset>> fetchNearStore(
      HomeScreenLoadingInput input) async {
    String url = APIUrls.homeScreenCustomer;
    url = url.replaceFirst(APIUrls.latitudeParam, input.latitude.toString());
    url = url.replaceFirst(APIUrls.longitudeParam, input.longitude.toString());
    url = url.replaceFirst(APIUrls.distanceParam, input.distance.toString());

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

  List<ProductInNearStoreDataset> parseDataFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ProductInNearStoreDataset> result = parsed
        .map<ProductInNearStoreDataset>(
            (json) => ProductInNearStoreDataset.fromJson(json))
        .toList();
    return result;
  }
}
