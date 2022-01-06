import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

String _showGoodTime(DateTime time) =>
    '${time.year}-${time.month}-${time.day} ${_showTime(time)}';
String _showTime(DateTime time) =>
    '${time.hour}:${time.minute > 9 ? time.minute : "0" + time.minute.toString()}';
String showTheBestTimeViewWithDate(DateTime date) {
  try {
    return DateTime.now().difference(date).inDays == 0
        ? _showTime(date)
        : DateTime.now().difference(date).inDays > 0
            ? _showGoodTime(date)
            : "0:00";
  } catch (e) {
    return "0:00";
  }
}

String showTheBestTimeViewWithDateFuture(DateTime date) {
  try {
    return date.difference(DateTime.now()).inDays == 0
        ? _showTime(date)
        : date.difference(DateTime.now()).inDays < 0
            ? _showGoodTime(date)
            : "0:00";
  } catch (e) {
    return "0:00";
  }
}

class MyTextFunctions {
  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static double getTheTextFactor(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.0008 +
      MediaQuery.textScaleFactorOf(context) * 0.7;

  static TextDirection getTextDirection() =>
      intl.Bidi.isRtlLanguage() ? TextDirection.rtl : TextDirection.ltr;

  static double getDynamicFontSize(
    int textLength,
    double yourSize,
    double width,
  ) {
    var x = ((textLength + 2) * yourSize) / width;
    if (x > 1) return ((yourSize) - (textLength / width) - x) * 0.8;
    return yourSize;
  }

  static String gettingShortName(String name) {
    final ch1 = name[0];
    final ch = name.split(' ');
    if (ch.length > 1) {
      final ch2 = ch[1][0].toUpperCase();
      return ch1 + ch2;
    }
    return ch1.toUpperCase();
  }
}
