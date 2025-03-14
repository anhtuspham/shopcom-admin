

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