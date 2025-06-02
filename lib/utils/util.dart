import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:shop_com_admin_web/providers/currency_provider.dart';

Color convertColorFromString(String data) {
  int value = int.parse(data, radix: 16);
  return Color(value);
}

String convertColorToString(Color color) {
  int tmp = (color.alpha << 24) | (color.red << 16) | (color.green << 8) | color.blue;
  return tmp.toRadixString(16).padLeft(8, '0');
}

DateTime? getDateTimeFromString(String datetime, String format) {
  try {
    return DateFormat(format).tryParse(datetime);
  } catch (e) {
    return null;
  }
}

String getStringFromDateTime(DateTime datetime, String format) {
  try {
    return DateFormat(format).format(datetime.toLocal());
  } catch (e) {
    return '';
  }
}

String upperCaseFirstLetter(String str){
  if(str.isEmpty) return '';
  return str[0].toUpperCase() + str.substring(1);
}

const double vndRate = 25980;

String formatMoney({required double money, Currency? currency}){
  switch(currency){
    case Currency.vnd:
      return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(money * vndRate);
    case Currency.usd:
      return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(money);
    case null:
      return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(money);
  }
}