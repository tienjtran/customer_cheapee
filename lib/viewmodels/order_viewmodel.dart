import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:customer_cheapee/datasets/order_dataset.dart';
import 'package:customer_cheapee/inputs/order_input.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class OrderViewModel {
  Future<List<OrderDataset>> getAllOrder(OrderInput input) async {
    String url = APIUrls.getAllOrder;
    url = url.replaceFirst(APIUrls.email, input.email);
    url = url.replaceFirst(APIUrls.pageSize, input.pageSize.toString());
    url = url.replaceFirst(APIUrls.pageNumber, input.pageNumber.toString());

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

  List<OrderDataset> parseDataFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<OrderDataset> result =
        parsed.map<OrderDataset>((o) => OrderDataset.fromJson(o)).toList();
    return result;
  }

  // //* Photo
  // Future<PhotoDataset> getPhoto(int photoId) async {
  //   String url = APIUrls.getPhoto;
  //   url = url.replaceFirst(APIUrls.photoId, photoId.toString());

  //   String mainUrl = FlutterConfig.get(ConfigKeyConstants.cheapeeApi) + url;
  //   final response = await http.get(
  //     mainUrl,
  //     headers: {
  //       HttpHeaders.authorizationHeader:
  //           APIConstansts.bearerAuthorization.replaceFirst(
  //         APIConstansts.tokenParam,
  //         await FirebaseAuth.instance.currentUser.getIdToken(),
  //       ),
  //     },
  //   );

  //   return parseDataFromPhotoJson(response.body);
  // }

  // PhotoDataset parseDataFromPhotoJson(String responseBody) {
  //   final Map<String, dynamic> parsed = jsonDecode(responseBody);
  //   PhotoDataset result = PhotoDataset.fromJson(parsed);
  //   return result;
  // }

// * get list OrderDetail
  Future<List<OrderDetailDataset>> getListOrderDetail(int orderId) async {
    String url = APIUrls.getAllOrderDetail;
    url = url.replaceFirst(APIUrls.orderId, orderId.toString());

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

    return parseListOrderDetailFromJson(response.body);
  }

  List<OrderDetailDataset> parseListOrderDetailFromJson(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<OrderDetailDataset> result = parsed
        .map<OrderDetailDataset>((o) => OrderDetailDataset.fromJson(o))
        .toList();
    return result;
  }
}
