import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';
import 'package:customer_cheapee/inputs/sign_up_input.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class CommonWidgetUtils {
  static TextStyle getCommonTextStyle(
      {double fontSize,
      FontWeight fontWeight,
      Color color,
      FontStyle fontStyle}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle);
  }
}

class CommonUtils {
  static String convertMinuteToStringTime(int time) {
    final int hour = time ~/ Constants.sixtyMinutes;
    final int minute = time % Constants.sixtyMinutes;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static String convertDoubleToMoney(double number) {
    MoneyFormatterOutput mfo = new FlutterMoneyFormatter(
        amount: number,
        settings: MoneyFormatterSettings(
          symbol: 'đ',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
          fractionDigits: 0,
        )).output;
    return mfo.symbolOnLeft;
  }

  static double decreaseHundredPercent(double from, double to) {
    return double.parse((1 - (to / from)).toStringAsFixed(1)) * 100;
  }
}

class FirebaseUtils {
  static Future<String> getDownloadUrls(String path) async {
    var storage = firebase_storage.FirebaseStorage.instance;
    String downloadURL = await storage.ref(path).getDownloadURL();
    return downloadURL;
  }

  static CollectionReference getCartReference() {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.cartCollectionId)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(FirebaseConstants.productField);
  }

  static DocumentReference getDocCart() {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.cartCollectionId)
        .doc(FirebaseAuth.instance.currentUser.uid);
  }

  static Future<int> getStoreIdInCart() async {
    int storeId;
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.cartCollectionId)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => storeId = value.data()[FirebaseConstants.storeIdKey])
        .catchError((_) => storeId = Constants.noStore);
    return storeId;
  }

  static addToCart(int storeId, int productId, int quantity) {
    var docCart = FirebaseUtils.getDocCart();
    docCart.set({
      FirebaseConstants.storeIdKey: storeId,
    });
    // var collectCarts = FirebaseFirestore.instance
    //     .collection(FirebaseConstants.cartCollectionId);
    // if (!(await docCart.get()).exists) {
    var docProduct = docCart
        .collection(FirebaseConstants.productField)
        .doc(productId.toString());
    int currentQua;
    docProduct
        .get()
        .then((docSnap) => {
              currentQua = docSnap.data()['quantity'],
              docCart
                  .collection(FirebaseConstants.productField)
                  .doc(productId.toString())
                  .update({
                FirebaseConstants.quantity: quantity + currentQua,
              })
            })
        .catchError(
      (_) {
        docProduct.set({
          FirebaseConstants.quantity: quantity,
        });
      },
    );
  }

  static Future deleteCartInFirestore() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    await getCartReference().get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
      return batch.commit();
    });
    await getDocCart().delete();
  }

  static Future<bool> updateRegistrationToken(String token) async {
    var url = FlutterConfig.get(ConfigKeyConstants.cheapeeApi) +
        APIUrls.updateRegistrationToken;
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
            'emailAddress': FirebaseAuth.instance.currentUser.email,
            'registrationToken': token,
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
