import 'package:flutter/material.dart';

import '../data/config/app_config.dart';

Color getColor(String key, Color color) {
  Color? v = app_config.appColor?.getValue(key);
  if (v == null) {
    return color;
  } else {
    return v;
  }
}

class ColorValueKey {
  static Color get textColor => getColor("textColor", Colors.black);
  static Color get mainColor => getColor("mainColor", Colors.white);
  static Color get lineChart => getColor("lineChart", Colors.grey);
  static Color get selectedColor => getColor("selectedColor", Colors.amber);
  static Color get selectedColor2 => getColor("selectedColor2", Colors.amber);
  static Color get iconBgColor => getColor("iconBgColor", Colors.blue);
  static Color get accountColor => getColor("accountColor", Colors.blueGrey);
  static Color get accountTextColor => getColor("accountTextColor", Colors.black);
  static Color get btnTextColor => getColor("btnTextColor", Colors.grey);
  static Color get tableBorder => getColor("tableBorder", Colors.black);
  static Color get expandBgColor => getColor("expandBgColor", Colors.grey);
  static Color get backgroundColor =>
      getColor("backgroundColor", Colors.white);
  static Color get headerTableColor => getColor("headerTableColor",Colors.blueGrey.shade100);
  static Color get errorTextColor  => getColor("errorTextColor", Colors.redAccent);

  static Color dividerColor = const Color(0xffA9A9A9);

  static Color get barrierColor => getColor("barrierColor", const Color(
      0xff535353).withOpacity(0.3));

  static Color lineBorder = const Color(0xffA9A9A9);


  static Color get lineButtonBorder =>
      getColor("lineButtonBorder",  Colors.black87);

  static Color get deleteColor => getColor("deleteColor", Colors.red.shade800);
  static Color get editColor => getColor("editColor", const Color(0xff007bff));
  static Color get buttonColor => getColor("buttonColor",  Colors.grey);



}
