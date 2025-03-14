import 'dart:ui';

Color convertColorFromString(String data) {
  int value = int.parse(data, radix: 16);
  return Color(value);
}

String convertColorToString(Color color) {
  int tmp = (color.alpha << 24) | (color.red << 16) | (color.green << 8) | color.blue;
  return tmp.toRadixString(16).padLeft(8, '0');
}