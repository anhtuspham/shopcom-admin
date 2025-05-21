

import 'dart:convert';

import 'package:flutter/material.dart';

import 'util.dart';

//  New version
class AppColor {
  final Map<String,Color> datas = Map();

  void loadFromStringJson(String buf) {
    Map<String,dynamic> tmps = json.decode(buf);
    datas.clear();
    for(MapEntry<String,dynamic> tmp in tmps.entries) {
      datas[tmp.key] = convertColorFromString(tmp.value.toString());
    }
  }

  void loadFromMap(Map<String, dynamic> buf) {
    datas.clear();
    for(MapEntry<String,dynamic> tmp in buf.entries) {
      datas[tmp.key] = convertColorFromString(tmp.value.toString());
    }
  }
  Color mainColor = const Color(0xffA3ADB2);
  Color backgroundColor = Colors.white;
  Color selectedColor = const Color(0xff96CCCC);
  Color selectedColor2 = const Color(0xff96CCCC);
  Color tableBorder = Colors.black;
  Color alternateCellBg = Colors.grey.shade300;
  Color textColor = const Color(0xFF0B2C43);
  Color buttonColor = const Color(0xFFEDF2F4);
  Color searchColor = Colors.white;
  Color activeTextColor =  Colors.white;
  Color btnTextColor = const Color(0xFF0B2C43);
  Color chartBgColor = Colors.white;
  Color lineChart = Colors.black;
  Color iconBgColor = Colors.teal;
  Color accountTextColor = Colors.black;
  Color accountColor = Colors.black;
  Color notificationExpandBgColor = Colors.lightBlue.shade50;
  Color notificationWarning = Colors.amber;
  Color scrollbarColor = const Color(0xff000000);
  Color expandBgColor = const Color(0xffe1f5fe);
  Color titleBlockBGColor = const Color(0xff000000);
  Color titleBlockTextColor = const Color(0xffffffff);
  Color activatedCheckboxColor = const Color(0xff563d2d);
  Color deactivatedCheckboxColor = const Color(0xff000000);

  Map<String,String> exportToJson() {
    Map<String,String> bufs = Map<String,String>();
    for(MapEntry<String,Color> buf in datas.entries) {
      bufs[buf.key] = convertColorToString(buf.value);
    }
    return bufs;
  }

  Color? getValue(String key) {
    MapEntry<String,Color>? item = datas.entries.where((s) => s.key.compareTo(key) == 0).firstOrNull;
    if(item == null) {
      return null;
    } else {
      return item.value;
    }
  }

  List<String> getKey(String value) {
    Color tmp = convertColorFromString(value);
    List<MapEntry<String,Color>> items = datas.entries.where((s) => s.value == tmp).toList();
    return items.map((s) => s.key).toList();
  }
}

class ItemAppColor {
  String code = "";
  AppColor keys = AppColor();

  ItemAppColor();

  ItemAppColor.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if(json['colors'] != null) {
      keys.loadFromMap(json['colors']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['colors'] = keys.exportToJson();
    return data;
  }
}