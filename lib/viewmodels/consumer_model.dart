import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/consumer_dataset.dart';
import 'package:customer_cheapee/inputs/consumer_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class ConsumerViewModel {
  Future<ConsumerDataset> getConsumerInfo(ConsumerLoadingInput input) async {
    String url = APIUrls.consumerInfo;
    url = url.replaceFirst(APIUrls.emailAddress, input.email);

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

  ConsumerDataset parseDataFromJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    ConsumerDataset result = ConsumerDataset.fromJson(parsed);
    return result;
  }
}
