import 'dart:convert';
import 'dart:io';
import 'package:customer_cheapee/inputs/sign_up_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class SignupModel {
  Future<bool> signUp(SignUpInput input) async {
    var url = FlutterConfig.get(ConfigKeyConstants.cheapeeApi) +
        APIUrls.signUpConsumer;

    var response = await http
        .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader:
                APIConstansts.bearerAuthorization.replaceFirst(
              APIConstansts.tokenParam,
              await FirebaseAuth.instance.currentUser.getIdToken(),
            ),
          },
          body: jsonEncode(<String, dynamic>{
            'emailAddress': input.emailAddress,
            'name': input.name,
            'age': input.age,
            'phoneNumber': input.phoneNumber,
            'address': input.address,
          }),
        )
        .catchError(
          (e) => {
            print(e),
          },
        );

    if (response.statusCode == StatusCodes.notFound) {
      return false;
    } else if (response.statusCode == StatusCodes.ok) {
      return true;
    } else {
      throw new Exception();
    }
  }
}
