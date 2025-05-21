import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemFilterData {
  String name = "";
  List<String> data = [];

  ItemFilterData({required this.name, required this.data});
}

class CustomPageController<T> {
  final List<T> data;
  List<T> _buffer = [];
  List<T> _selected = [];
  late ValueNotifier<int> totalData = ValueNotifier(data.length);
  List<T>? selectData = [];

  List<ItemFilterData> _configFilter = [];
  List<T> dataEmpty = [];
  String search = "";
  List<ItemFilterData> _listDataFilter = [];
  Map<String, Comparator<dynamic>>? comparatorsColumn;

  void setConfigFilter(String name, List<String> data) {
    ItemFilterData? _tmp =
        _configFilter.where((s) => s.name.compareTo(name) == 0).firstOrNull;
    if (_tmp == null) {
      ItemFilterData _buf = ItemFilterData(name: name, data: data);
      _configFilter.add(_buf);
    } else {
      _tmp.data = data;
    }
    filterData();
  }

  void setSelect( List<T> v)
  {
    _selected = v;
  }

  void setSelectDataTable()
  {
    _selected = selectData ?? [];
  }

  ValueNotifier<Map<String, bool>> filterStates = ValueNotifier({});

  List<String> getConfigFilter(String name) {
    ItemFilterData? _tmp =
        _configFilter.where((s) => s.name.compareTo(name) == 0).firstOrNull;
    return _tmp?.data ?? [];
  }

  void updateFilterState(String name) {
    bool hasFilter = getConfigFilter(name).isNotEmpty;
    filterStates.value = {...filterStates.value, name: hasFilter};
  }



  void clearFilter()
  {
    filterStates.value = {};
  }

  List<String> getListConfigFilter() {
    List<String> _result = [];
    _configFilter.forEach((s) {
      _result.add(s.name);
    });
    return _result;
  }
  ValueNotifier<Map<String, bool?>> filterSort = ValueNotifier({});

  void updateSortState(String selectedKey, bool hasSort) {
    filterSort.value = {
      for (var key in filterSort.value.keys) key: null,
      selectedKey: hasSort
    };
  }

  void sortData(
      String sortKey, {
        bool? asc,
      }) {
    _buffer.sort((a, b) {
      final mapA = (a as dynamic).toJson();
      final mapB = (b as dynamic).toJson();

      var valueA = mapA[sortKey];
      var valueB = mapB[sortKey];
      final isAscending = asc ?? true;

      final comparator = comparatorsColumn?[sortKey];

      if (valueA == null && valueB == null) return 0;
      if (valueA == null) return isAscending ? -1 : 1;
      if (valueB == null) return isAscending ? 1 : -1;

      try {
        if (comparator != null) {
          return isAscending ? comparator(valueA, valueB) : comparator(valueB, valueA);
        }
      } catch (_) {}

      return (valueA is Comparable && valueB is Comparable)
          ? (isAscending ? valueA.compareTo(valueB) : valueB.compareTo(valueA))
          : 0;
    });
  }

  void filterData() {
    _buffer.clear();
    for (int i = 0; i < data.length; i++) {
      Map<String, dynamic> _tmp = json.decode(jsonEncode(data[i]));
      bool _flag = true;
      for (int j = 0; j < _configFilter.length; j++) {
        MapEntry<String, dynamic>? _buf = _tmp.entries
            .where((s) => s.key.compareTo(_configFilter[j].name) == 0)
            .firstOrNull;
        if (_buf == null) {
          _flag = false;
          break;
        } else {
          if (_configFilter[j].data.isNotEmpty) {
            String? _finded = _configFilter[j]
                .data
                .where((s) => s.compareTo(_buf.value.toString()) == 0)
                .firstOrNull;
            if (_finded == null) {
              _flag = false;
              break;
            }
          }
        }
      }
      if (_flag == true) {
        _buffer.add(data[i]);
      }
    }
    // searchData();
    // totalData.value = _buffer.length;

  }

  void setSearch(String v,List<String> _search ) {
    search = v;
    searchData(_search);
  }

  void searchData(List<String> _search) {
    _buffer.clear();

    for (int i = 0; i < data.length; i++) {
      Map<String, dynamic> _tmp = json.decode(jsonEncode(data[i]));

      bool _flag;
      if (_search.isEmpty) {
        // Nếu _search trống, tìm kiếm trong tất cả các key
        _flag = _tmp.values.any((value) =>
            value.toString().toLowerCase().contains(search.toLowerCase()));
      } else {
        // Nếu _search có giá trị, chỉ tìm trong các key được chỉ định
        _flag = _search.any((key) =>
        _tmp.containsKey(key) &&
            _tmp[key].toString().toLowerCase().contains(search.toLowerCase()));
      }

      if (_flag) {
        _buffer.add(data[i]);
      }
    }

    totalData.value = _buffer.length;
  }
  List<String> getColumnFilterData<T>(String columnName) {
    List<String> value = [];
    List datas = data;
    for (T data in datas) {
      //Map<String, dynamic> _temp = Map.from(data as Map<Object?, Object?>);
      Map<String, dynamic> _temp = json.decode(jsonEncode(data));
      value.add(_temp[columnName].toString());
    }
    return value;
  }

  List<ItemFilterData> get listDataFilter => _listDataFilter;

  List<ItemFilterData> get configFilter => _configFilter;

  List<T> get buffer => _buffer;

  List<T> get selected => _selected;

/*  set selected(List<T> tmp) {
    _selected.clear();
    _selected.addAll(tmp);
  }*/

  int index_page = 0;
  int _number_item_in_page = 9999999;
  final int Function(T a, T b) funcCompare;

  CustomPageController(
      {required this.data,
        required this.funcCompare,
        required this.dataEmpty}) {
    filterData();
    // _buffer.addAll(this.data);
  }

  void setData(List<T> buf) {
    data.clear();
    data.addAll(buf);
    filterData();
    searchData([]);
  }
  void setComparatorsColumn(Map<String, Comparator<dynamic>> v)
  {
    comparatorsColumn = v;
  }

  void setNumberItemInPage(int number) {
    _number_item_in_page = number;
    if (index_page * _number_item_in_page >= _buffer.length) {
      index_page =
          (_buffer.length.toDouble() / _number_item_in_page.toDouble()).ceil() -
              1;
      if (index_page < 0) {
        index_page = 0;
      }
    }
  }

  int getNumberData() {
    return _buffer.length;
  }

  int getNumberItemInPage() {
    return _number_item_in_page;
  }

  int getCountPage() {
    int page =
    (_buffer.length.toDouble() / _number_item_in_page.toDouble()).ceil();
    if (page < 1) {
      page = 1;
    }
    return page;
  }

  T? getItemWithIndex(int index) {
    int current_index = index_page * _number_item_in_page + index;
    if (current_index < _buffer.length) {
      return _buffer[current_index];
    } else {
      return null;
    }
  }

  int getNumberItemOfPage(int indexPage) {
    int numberItemAfter = indexPage * _number_item_in_page;
    if (numberItemAfter >= _buffer.length) {
      return -1;
    }
    int tmp = _buffer.length - numberItemAfter;
    if (tmp >= _number_item_in_page) {
      return _number_item_in_page;
    } else {
      return tmp;
    }
  }

  List<T> getItemOfPage(int indexPage) {
    int numberItemAfter = indexPage * _number_item_in_page;
    if(numberItemAfter >= _buffer.length) {
      return [];
    }
    int tmp = _buffer.length - numberItemAfter;
    List<T> _tmp_buffer = [];
    if(tmp >= _number_item_in_page) {
      _tmp_buffer = _buffer.sublist(numberItemAfter, numberItemAfter+_number_item_in_page);
    } else {
      _tmp_buffer = _buffer.sublist(numberItemAfter);
    }

    /*  for (int i = 0; i < _selected.length; i++) {
      T? _temp = _tmp_buffer.where((x) => funcCompare(x, _selected[i]) == 0).firstOrNull;
      if(_temp == null) {
        _selected.removeAt(i);
        i--;
      }
    }*/

    return _tmp_buffer;
  }

  List<int> getIndexSelectedItemOfPage(int indexPage) {
    int numberItemAfter = indexPage * _number_item_in_page;
    if (numberItemAfter >= _buffer.length) {
      return [];
    }
    int tmp = _buffer.length - numberItemAfter;
    List<T> buffer = [];
    if (tmp >= _number_item_in_page) {
      buffer = _buffer.sublist(
          numberItemAfter, numberItemAfter + _number_item_in_page);
    } else {
      buffer = _buffer.sublist(numberItemAfter);
    }
    List<int> temp = [];
    for (int index = 0; index < buffer.length; index++) {
      if (_selected
          .where((s) => funcCompare(s, buffer[index]) == 0)
          .firstOrNull !=
          null) {
        temp.add(index);
      }
    }
    return temp;
  }

  void setPage(int page) {
    this.index_page = page;
  }

  List<T> getItem() {
    int lastPage = getCountPage();
    if (index_page >= lastPage) {
      index_page = lastPage--;
    }
    return getItemOfPage(index_page);
  }

  List<String> getValueCol(String name) {
    List<String> buf = [];
    for (int i = 0; i < data.length; i++) {
      Map<String, dynamic> _tmp = json.decode(jsonEncode(data[i]));
      if (_tmp.keys.isNotEmpty) {
        for (int j = 0; j < _tmp.length; j++) {
          if (_tmp.entries.elementAt(j).key.compareTo(name) == 0) {
            String _value = _tmp.entries.elementAt(j).value.toString();
            if (buf.where((s) => s.compareTo(_value) == 0).firstOrNull ==
                null) {
              buf.add(_value);
            }
            break;
          }
        }
      }
    }
    return buf;
  }

  List<int> getIndexSelectedItem() {
    int lastPage = getCountPage();
    if (index_page >= lastPage) {
      index_page = lastPage--;
    }
    return getIndexSelectedItemOfPage(index_page);
  }

  T? getChildWithPage(int index) {
    int tmp = index_page * _number_item_in_page + index;
    if (tmp < _buffer.length) {
      return _buffer[tmp];
    } else {
      return null;
    }
  }

  void clearSelected() {
    _selected.clear();
  }

  bool addSelectedWithIndex(int index) {
    int index0 = index_page * _number_item_in_page + index;
    if (index0 < _buffer.length) {
      if (_selected
          .where((s) => funcCompare(s, _buffer[index0]) == 0)
          .firstOrNull ==
          null) {
        _selected.add(_buffer[index0]);
      }
      return true;
    } else {
      return false;
    }
  }

  bool removeSelectedWithIndex(int index) {
    int index0 = index_page * _number_item_in_page + index;
    if (index0 < _buffer.length) {
      T? tmp = _selected
          .where((s) => funcCompare(s, _buffer[index0]) == 0)
          .firstOrNull;
      if (tmp != null) {
        _selected.remove(tmp);
      }
      return true;
    } else {
      return false;
    }
  }

}
