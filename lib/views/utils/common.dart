import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
}
