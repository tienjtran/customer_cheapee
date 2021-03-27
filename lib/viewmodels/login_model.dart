import 'dart:io';

import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class LoginModel {
  Future<bool> isSignup(String emailAddress) async {
    var url =
        FlutterConfig.get(ConfigKeyConstants.cheapeeApi) + APIUrls.consumerInfo;
    url = url.replaceFirst(APIUrls.emailAddress, emailAddress);
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            APIConstansts.bearerAuthorization.replaceFirst(
          APIConstansts.tokenParam,
          await FirebaseAuth.instance.currentUser.getIdToken(),
        ),
      },
    );
    if (response.statusCode == StatusCodes.notFound) {
      return false;
    } else if (response.statusCode == StatusCodes.ok) {
      return true;
    } else {
      throw Exception();
    }
  }
}
