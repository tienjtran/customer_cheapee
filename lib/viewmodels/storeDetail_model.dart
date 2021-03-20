import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/search_dataset.dart';
import 'package:customer_cheapee/datasets/storeDetail_dataset.dart';
import 'package:customer_cheapee/inputs/storeDetail_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class StoreDetailViewModel {
  Future<List<StoreDetailDataset>> getStoreDetail(
      StoreDetailScreenLoadingInput input) async {
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

  List<StoreDetailDataset> parseDataFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<StoreDetailDataset> result = parsed
        .map<StoreDetailDataset>((json) => StoreDetailDataset.fromJson(json))
        .toList();
    return result;
  }
}
