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

  // * Brand
  Future<BrandDataset> getBrand(int brandId) async {
    String url = APIUrls.getBrand;
    url = url.replaceFirst(APIUrls.brandId, brandId.toString());

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

    return parseDataFromBrandJson(response.body);
  }

  BrandDataset parseDataFromBrandJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    BrandDataset result = BrandDataset.fromJson(parsed);
    return result;
  }

  // * Manufacturer
  Future<ManufacturerDataset> getManufacturer(int manufacturerId) async {
    String url = APIUrls.getManufacturer;
    url = url.replaceFirst(APIUrls.manufacturerId, manufacturerId.toString());

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

    return parseDataFromManufacturerJson(response.body);
  }

  ManufacturerDataset parseDataFromManufacturerJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    ManufacturerDataset result = ManufacturerDataset.fromJson(parsed);
    return result;
  }

  //* Photo
  Future<PhotoDataset> getPhoto(int photoId) async {
    String url = APIUrls.getPhoto;
    url = url.replaceFirst(APIUrls.photoId, photoId.toString());

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

    return parseDataFromPhotoJson(response.body);
  }

  PhotoDataset parseDataFromPhotoJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    PhotoDataset result = PhotoDataset.fromJson(parsed);
    return result;
  }
}
