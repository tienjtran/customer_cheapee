import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
