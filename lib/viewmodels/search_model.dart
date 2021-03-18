import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/search_dataset.dart';
import 'package:customer_cheapee/inputs/search_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class SearchViewModel {
  Future<List<SearchStoreDataset>> getNearItems(
      SearchScreenLoadingInput input) async {
    String url = APIUrls.searchScreen;
    url = url.replaceFirst(APIUrls.latitudeParam, input.latitude.toString());
    url = url.replaceFirst(APIUrls.longitudeParam, input.longitude.toString());
    url = url.replaceFirst(APIUrls.distanceParam, input.distance.toString());
    url = url.replaceFirst(APIUrls.searchName, input.name);

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

  List<SearchStoreDataset> parseDataFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<SearchStoreDataset> result = parsed
        .map<SearchStoreDataset>((json) => SearchStoreDataset.fromJson(json))
        .toList();
    return result;
  }
}
