import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/store_dataset.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class StoreViewModel {
  //* Store
  Future<StoreDataset> getStore(int storeId) async {
    String url = APIUrls.getStore;
    url = url.replaceFirst(APIUrls.storeId, storeId.toString());

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

    return parseDataFromStoreJson(response.body);
  }

  StoreDataset parseDataFromStoreJson(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<StoreDataset> result =
        parsed.map<StoreDataset>((s) => StoreDataset.fromJson(s)).toList();
    return result.single;
  }
}
