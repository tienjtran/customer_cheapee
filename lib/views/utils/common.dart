import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final int hour = time ~/ Constants.SIXTY_MINUTES;
    final int minute = time % Constants.SIXTY_MINUTES;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static String convertDoubleToIntegerString(double number) {
    NumberFormat numberFormat =
        new NumberFormat(Constants.INTEGER_NUMBER_PATTERN, Constants.US_REGION);
    return numberFormat.format(number);
  }
}
