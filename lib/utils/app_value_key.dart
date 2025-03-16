//  New version
import 'dart:convert';

import '../data/config/app_config.dart';

class AppKeyValue {
  final Map<String,String> datas = Map();

  void loadFromStringJson(String buf) {
    Map<String,dynamic> tmps = json.decode(buf);
    datas.clear();
    for(MapEntry<String,dynamic> tmp in tmps.entries) {
      datas[tmp.key] = tmp.value.toString();
    }
  }

  void loadFromMap(Map<String, dynamic> buf) {
    datas.clear();
    for(MapEntry<String,dynamic> tmp in buf.entries) {
      datas[tmp.key] = tmp.value.toString();
    }
  }

  String exportToJson() {
    return json.encode(datas);
  }

  String? getValue(String key) {
    MapEntry<String,String>? item = datas.entries.where((s) => s.key.compareTo(key) == 0).firstOrNull;
    if(item == null) {
      return null;
    } else {
      return item.value;
    }
  }

  List<String> getKey(String value) {
    List<MapEntry<String,String>> items = datas.entries.where((s) => s.value.compareTo(value) == 0).toList();
    return items.map((s) => s.key).toList();
  }
}

class ItemAppKeyValue {
  String code = "";
  AppKeyValue keys = AppKeyValue();

  ItemAppKeyValue();

  ItemAppKeyValue.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if(json['keys'] != null) {
      keys.loadFromMap(json['keys']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['keys'] = keys.datas;
    return data;
  }
}
