import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;

class MyTextFunctions {
  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static double getTheTextFactor(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.0008 +
      MediaQuery.textScaleFactorOf(context) * 0.7;
  static double getTheTextFactorFix(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.0018;
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
}
