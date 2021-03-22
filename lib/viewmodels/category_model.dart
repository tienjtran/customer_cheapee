import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/category_dataset.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class CategoryViewModel {
  Future<List<CategoryDataset>> getListCategory() async {
    String url = APIUrls.getAllCategory;

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

  List<CategoryDataset> parseDataFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoryDataset> result = parsed
        .map<CategoryDataset>((json) => CategoryDataset.fromJson(json))
        .toList();
    return result;
  }
}
