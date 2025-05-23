import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/config/app_config.dart';
import '../color_value_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../context_extension.dart';
import '../custom_page_controller.dart';
import '../global_key.dart';
import '../local_value_key.dart';
import 'button_widget.dart';
import 'dialog_image.dart';

class CustomDataSource<T> extends DataGridSource {
  final CustomPageController<T> controller;
  final DataGridController dataGridController;
  final List<DataGridRow> _data = [];

  final List<String> _label = [];
  final List<double> _sizes = [];
  final List<String> _types = [];
  final List<bool> _filter = [];
  final List<bool> _sort = [];
  final List<String> _search = [];

  bool isExtended = false;

  // final List<String> _column = [];
  bool Function(String col)? filterObjectActivating;
  BuildContext? parent;
  bool showOrdinalNumber;
  final Function(T obj)? showExtension;

  // int? get rowsPerPage => _rowsPerPage;
  // set rowsPerPage(int value) { _rowsPerPage = value};

  CustomDataSource(
      {this.parent,
      required this.controller,
      this.isExtended = false,
      this.showExtension,
      this.filterObjectActivating,
      required this.showOrdinalNumber,
      required this.dataGridController}) {
    // _rowsPerPage.value(10);
  }

  void setConfigSize(List<double> sizes) {
    _sizes.clear();
    _sizes.addAll(sizes);
  }

  void setType(List<String> types) {
    _types.clear();
    _types.addAll(types);
  }

  void setConfigFilter(List<bool> filter) {
    _filter.clear();
    _filter.addAll(filter);
  }

  void setConfigSort(List<bool> sort) {
    _sort.clear();
    _sort.addAll(sort);
  }

  void setConfigSearch(List<String> search) {
    _search.clear();
    _search.addAll(search);
  }

  bool checkFilterTableHasValues(Map filterTable) {
    for (var value in filterTable.values) {
      if (value != null && value.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  void setData(List<T> datas, List<T> dataEmpty) {
    _data.clear();
    _label.clear();
    // dataGridController.selectedRows = [];
    bool first = true;

    if (datas.isNotEmpty) {
      for (T data in datas) {
        //Map<String, dynamic> _temp = Map.from(data as Map<Object?, Object?>);
        List<DataGridCell> cells = [];
        Map<String, dynamic> temp0 = json.decode(jsonEncode(data));
        for (MapEntry<String, dynamic> _tmp in temp0.entries) {
          if (_tmp.value.runtimeType == String) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
            cells.add(DataGridCell<String>(columnName: _tmp.key, value: _tmp.value as String));
          } else if (_tmp.value.runtimeType == int) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
            cells.add(DataGridCell<int>(columnName: _tmp.key, value: _tmp.value as int));
          } else if (_tmp.value.runtimeType == double) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
            cells.add(DataGridCell<double>(columnName: _tmp.key, value: _tmp.value as double));
          }
        }
        if (cells.isNotEmpty) {
          _data.add(DataGridRow(cells: cells));
        }
        if (first) {
          first = false;
        }
      }
    } else {
      for (T data in dataEmpty) {
        Map<String, dynamic> temp = json.decode(jsonEncode(data));
        for (MapEntry<String, dynamic> _tmp in temp.entries) {
          if (_tmp.value.runtimeType == String) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
          } else if (_tmp.value.runtimeType == int) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
          } else if (_tmp.value.runtimeType == double) {
            if (first) {
              if (_label.where((s) => s.compareTo(_tmp.key) == 0).isEmpty) {
                _label.add(_tmp.key);
              }
            }
          }
        }
        if (first) {
          first = false;
        }
      }
    }

    Future.delayed(
      const Duration(milliseconds: 1),
      () {
        List<int> tmps = controller.getIndexSelectedItem();
        for (int _tmp in tmps) {
          dataGridController.selectedRow = _data[_tmp];
        }
        try {
          if (tmps.isNotEmpty) {
            dataGridController.moveCurrentCellTo(RowColumnIndex(rows.length, 0));
            dataGridController.scrollToRow(0);
          }
        } catch (_) {}
        //notifyDataSourceListeners();
        //notifyListeners();
      },
    );
    notifyDataSourceListeners();
  }

  @override
  List<DataGridRow> get rows => _data;

  List<String> get cols => _label;

  List<GridColumn> buildCol() {
    // Map<String, dynamic> store = app_text.toJson();

    List<GridColumn> items = [];
    int index = 0;

    for (String _tmp in _label) {
      String? value = getText(_tmp, _tmp);
      List<String> data = controller.getColumnFilterData(_tmp).toSet().toList();
      if (index < _sizes.length && _sizes[index] > 0) {
        items.add(
          GridColumn(
            width: _sizes[index],
            allowFiltering: false,
            allowSorting: false,
            columnName: _tmp,
            label: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      value,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: ColorValueKey.textColor,
                      ),
                    ),
                  ),
                  if (_sort.isEmpty || index >= _sort.length || _sort[index] != false)
                    ValueListenableBuilder<Map<String, bool?>>(
                      valueListenable: controller.filterSort,
                      builder: (context, filterStates, child) {
                        bool? isSorted = filterStates[_tmp];

                        return InkWell(
                          onTap: () async {
                            bool newSortState = isSorted == null ? true : !isSorted;
                            controller.updateSortState(_tmp, newSortState);
                            controller.sortData(_tmp, asc: newSortState);
                            notifyListeners();
                          },
                          child: Icon(
                            isSorted == null
                                ? Icons.unfold_more
                                : isSorted
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                            color: ColorValueKey.textColor,
                          ),
                        );
                      },
                    ),
                  if (_filter.isEmpty || index >= _filter.length || _filter[index] != false)
                    ValueListenableBuilder<Map<String, bool>>(
                      valueListenable: controller.filterStates,
                      builder: (context, filterStates, child) {
                        bool isFiltered = filterStates[_tmp] ?? false;

                        return InkWell(
                          onTap: () async {
                            await showMyDialog(data, _tmp);
                            controller.updateFilterState(_tmp);
                          },
                          child: Icon(
                            isFiltered ? Icons.filter_list_alt : Icons.filter_alt_outlined,
                            color: ColorValueKey.textColor,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      } else {
        items.add(
          GridColumn(
            //allowFiltering: true,
            allowSorting: false,
            allowFiltering: false,
            columnName: _tmp,
            label: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      value,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: ColorValueKey.textColor,
                      ),
                    ),
                  ),
                  if (_sort.isEmpty || index >= _sort.length || _sort[index] != false)
                    ValueListenableBuilder<Map<String, bool?>>(
                      valueListenable: controller.filterSort,
                      builder: (context, filterStates, child) {
                        bool? isSorted = filterStates[_tmp];

                        return IconButton(
                          onPressed: () async {
                            bool newSortState = isSorted == null ? true : !isSorted;
                            controller.updateSortState(_tmp, newSortState);
                            controller.sortData(_tmp, asc: newSortState);
                            notifyListeners();
                          },
                          icon: Icon(
                            isSorted == null
                                ? Icons.unfold_more
                                : isSorted
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                            color: ColorValueKey.textColor,
                          ),
                        );
                      },
                    ),
                  if (_filter.isEmpty || index >= _filter.length || _filter[index] != false)
                    ValueListenableBuilder<Map<String, bool>>(
                      valueListenable: controller.filterStates,
                      builder: (context, filterStates, child) {
                        bool isFiltered = filterStates[_tmp] ?? false;

                        return IconButton(
                          onPressed: () async {
                            await showMyDialog(data, _tmp);
                            controller.updateFilterState(_tmp);
                          },
                          icon: Icon(
                            isFiltered ? Icons.filter_list_alt : Icons.filter_alt_outlined,
                            color: ColorValueKey.textColor,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      }

      index++;
    }
    if (isExtended) {
      if (index < _sizes.length && _sizes[index] > 0) {
        items.add(
          GridColumn(
            width: _sizes[index],
            allowFiltering: false,
            allowSorting: false,
            columnName: "extension",
            label: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(
                'Thao tác',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: ColorValueKey.textColor,
                ),
              ),
            ),
          ),
        );
      } else {
        items.add(
          GridColumn(
            allowFiltering: false,
            allowSorting: false,
            columnName: "extension",
            label: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(
                'Thao tác',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: ColorValueKey.textColor,
                ),
              ),
            ),
          ),
        );
      }
    }
    return items;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    List<Widget> children = [];
    int length = row.getCells().length;

    if (showOrdinalNumber) {
      int index = rows.indexOf(row);
      int stt = index + 1;

      children.add(Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        child: Text(
          textAlign: TextAlign.center,
          stt.toString(),
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: ColorValueKey.textColor,
          ),
        ),
      ));
    }

    for (int i = 0; i < length; i++) {
      bool state = false;
      if (filterObjectActivating != null) {
        state = filterObjectActivating!(row.getCells()[i].columnName.toString());
      }

      // print('state: $i $state');
      if (i < _types.length) {
        if (_types[i].compareTo("image") == 0) {
          children.add(
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  if (parent != null) {
                    showImageDialog(parent!, url: row.getCells()[i].value.toString());
                  }
                },
                child: CachedNetworkImage(
                  imageUrl: row.getCells()[i].value.toString(),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        } else if (_types[i].compareTo("image_non_popup") == 0) {
          children.add(
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5.0),
              child: CachedNetworkImage(
                imageUrl: row.getCells()[i].value.toString(),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        } else if (_types[i].compareTo("online") == 0) {
          children.add(Center(
            child: Container(
              color: Colors.transparent,
              child: Icon(
                Icons.circle,
                color: row.getCells()[i].value == 'true' ? Colors.green : Colors.grey,
              ),
            ),
          ),);
        } else if (_types[i].compareTo("icon") == 0) {
          children.add(
            state
                ? Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Icon(
                IconData(
                  row.getCells()[i].value,
                  fontFamily: 'MaterialIcons',
                ),
                color: ColorValueKey.textColor,
              ),
            )
                : Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        IconData(
                          row.getCells()[i].value,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: ColorValueKey.textColor,
                      ),
                    ),
                  ),
          );
        } else if (_types[i].compareTo("subText") == 0) {
          // print('${row.getCells()[i].value.toString()} ${row.getCells()[i].value.toString()}');
          String subtext = row.getCells()[i].value.toString();
          children.add(Builder(
            builder: (context) {
              if (subtext.length > 60) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: SelectableText(
                    '${subtext.substring(0, 60)}...',
                    // maxLines: 2,
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: SelectableText(
                    subtext,
                  ),
                );
              }
            },
          ));
        } else {
          children.add(
            state
                ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5.0),
              child: SelectableText(
                row.getCells()[i].value.toString(),
              ),
            )
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      textAlign: TextAlign.center,
                      row.getCells()[i].value.toString(),
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: ColorValueKey.textColor,
                      ),
                    ),
                  ),
          );
        }
      } else {
        children.add(state
            ? Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5.0),
          child: SelectableText(
            row.getCells()[i].value.toString(),
          ),
        )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                child: SelectableText(
                  textAlign: TextAlign.center,
                  row.getCells()[i].value.toString(),
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: ColorValueKey.textColor,
                  ),
                ),
              ));
      }
    }
    // for(DataGridCell cell in row.getCells()) {
    //   children.add(Container(
    //     alignment: Alignment.center,
    //     padding: const EdgeInsets.all(5.0),
    //     child: Text(
    //       cell.value.toString(),
    //       style: TextStyle(
    //         fontStyle: FontStyle.normal,
    //         fontWeight: FontWeight.normal,
    //         color: app_color.textColor,
    //       ),
    //     ),
    //   ));
    // }
    if (isExtended) {
      if (showExtension != null) {
        int tmpIndex = _data.indexWhere((s) => s == row, 0);
        if (tmpIndex >= 0) {
          T? item = controller.getChildWithPage(tmpIndex);
          if (item != null) {
            children.add(showExtension!(item));
          } else {
            children.add(
              Container(
                alignment: Alignment.center,
                child: const Text(" * * Extended * *"),
              ),
            );
          }
        } else {
          children.add(
            Container(
              alignment: Alignment.center,
              child: const Text(" * Extended * "),
            ),
          );
        }
      } else {
        children.add(
          Container(
            alignment: Alignment.center,
            child: const Text("Extended"),
          ),
        );
      }
    }

    return DataGridRowAdapter(
      cells: children,
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    controller.setPage(newPageIndex);
    setData(controller.getItem(), controller.dataEmpty);
    notifyDataSourceListeners();
    //notifyListeners();
    return true;
  }

  void addSelectedItem(List<DataGridRow> items) {
    for (DataGridRow item in items) {
      int index = _data.indexWhere((s) => s == item, 0);
      if (index >= 0) {
        controller.addSelectedWithIndex(index);
      }
    }
  }

  void removeSelectItem(List<DataGridRow> items) {
    for (DataGridRow item in items) {
      int index = _data.indexWhere((s) => s == item, 0);
      if (index >= 0) {
        controller.removeSelectedWithIndex(index);
      }
    }
  }

  Future<void> showMyDialog(List<String> data, String columnName) async {
    List<String>? dataFilter = data;
    List<String> filter = controller.getConfigFilter(columnName);
    List<String> tempFilter = List.from(filter); // Tạo biến tạm để giữ giá trị filter

    TextEditingController search = TextEditingController();
    search.addListener(() {
      if (search.text.isNotEmpty) {
        dataFilter = data.where((element) => (element.toString().toLowerCase()).contains(search.text.toLowerCase())).toList();
      } else {
        dataFilter = data;
      }
    });
    final scrollController = ScrollController();
    if (scaffoldKey.currentContext != null) {
      return await showDialog<void>(
        barrierColor: ColorValueKey.barrierColor,
        context: scaffoldKey.currentContext!,
        builder: (BuildContext context) {
          return BaseSelectDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              dataFilter = data.where((element) => (element.toString().toLowerCase()).contains(value.toLowerCase())).toList();
                            });
                          } else {
                            setState(() {
                              dataFilter = data;
                            });
                          }
                        },
                        // style: TextStyle(fontSize: ThemeConfig.defaultSize),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorValueKey.textColor,
                          ),
                          // contentPadding: ThemeConfig.contentPadding,
                          counter: const SizedBox(),
                          hintText: 'Tìm kiếm',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (dataFilter != null && dataFilter!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (tempFilter.length != dataFilter?.length) {
                                tempFilter.clear();
                                tempFilter.addAll(dataFilter ?? []);
                              } else {
                                tempFilter = [];
                              }
                            });
                          },
                          child: ListTile(
                            leading: Checkbox(
                              value: tempFilter.length == dataFilter?.length,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    tempFilter.clear();
                                    tempFilter.addAll(dataFilter ?? []);
                                  } else {
                                    tempFilter = [];
                                  }
                                });
                              },
                            ),
                            title: Text(
                              'Chọn tất cả',
                              style: TextStyle(color: ColorValueKey.textColor),
                            ),
                          ),
                        ),
                      if (dataFilter != null && dataFilter!.isNotEmpty) Divider(thickness: 1, color: ColorValueKey.dividerColor),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                          child: RawScrollbar(
                        trackVisibility: false,
                        // thumbVisibility: true,
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        crossAxisMargin: 0,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: dataFilter?.length,
                          itemBuilder: (context, index) {
                            final e = dataFilter?[index] ?? "";
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (tempFilter.contains(e)) {
                                        tempFilter.remove(e);
                                      } else {
                                        tempFilter.add(e);
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: tempFilter.contains(e),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            tempFilter.add(e);
                                          } else {
                                            tempFilter.remove(e);
                                          }
                                        });
                                      },
                                    ),
                                    title: Text(
                                      (e.toString() == '') ? 'Trống' : e.toString(),
                                      style: TextStyle(color: ColorValueKey.textColor),
                                    ),
                                  ),
                                ),
                                Divider(thickness: 1, color: ColorValueKey.dividerColor)
                              ],
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
            onConfirm: () {
              filter.clear();
              filter.addAll(tempFilter);
              controller.setConfigFilter(columnName, filter);
              notifyListeners();
              context.pop();
            },
            title: Text(
              'Tìm kiếm: ${getText(columnName, columnName)}',
              style: TextStyle(color: ColorValueKey.textColor),
            ),
          );
        },
      );
    }
  }
}

class CustomDataTable<T> {
  final CustomPageController<T> controller;
  final DataGridController dataGridController = DataGridController();
  final DataPagerDelegate dataPagerDelegate = DataPagerDelegate();
  final GlobalKey<SfDataGridState> _dataGridKey = GlobalKey<SfDataGridState>();
  final String? titleHeader;
  // final bool isAdmin = app_config.user?.role == 'admin';
  final bool isShowBottomWidget;

  late CustomDataSource<T> _dataSource;
  final Widget? bottomWidget;
  final Widget? topWidget;
  final bool showExport;
  final bool showBottomWidget;
  final bool isShowCheckbox;
  bool Function(String col)? filterObjectActivating;
  void Function(String col, T obj)? onObjectActivated;
  double Function(int index)? getHeightRow;

  bool filterCellActivating(RowColumnIndex currentRowColumnIndex, RowColumnIndex previousRowColumnIndex) {
    int col = currentRowColumnIndex.columnIndex;
    if (showOrdinalNumber) {
      col--;
    }
    int row = currentRowColumnIndex.rowIndex;
    T? tmp = controller.getItemWithIndex(row);
    if (tmp != null) {
      Map<String, dynamic> tmp0 = json.decode(jsonEncode(tmp));
      if (col < ((isSelectionRow && isShowCheckbox) ? tmp0.entries.length + 1 : tmp0.entries.length)) {
        if (filterObjectActivating != null) {
          int index = (isSelectionRow && isShowCheckbox) ? col - 1 : col;
          if (index < 0) {
            return true;
          } else {
            bool state = filterObjectActivating!(tmp0.entries.elementAt(index).key);
            if (state) {
              onObjectActivated!(tmp0.entries.elementAt(index).key, tmp);
              return false;
            }
            return true;
          }
        }
      }
    }
    return true;
  }

  void onCellActivated(RowColumnIndex currentRowColumnIndex, RowColumnIndex previousRowColumnIndex) {
    int col = currentRowColumnIndex.columnIndex;
    int row = currentRowColumnIndex.rowIndex;
    T? tmp = controller.getItemWithIndex(row);
    if (tmp != null) {
      Map<String, dynamic> tmp0 = json.decode(jsonEncode(tmp));
      if (col < tmp0.entries.length) {
        if (onObjectActivated != null) {
          onObjectActivated!(tmp0.entries.elementAt(col).key, tmp);
        }
      }
    }

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        dataGridController.selectedRows = [];
        /*     if (refresh != null) {
          refresh!();
        }*/
        // if(dataGridController.selectedRows != null) {
        //   dataGridController.selectedRow = [];
        // }
      },
    );
  }

  final Function(T obj)? showExtension;
  final void Function()? refresh;
  final ValueNotifier<double> pageCount = ValueNotifier<double>(1);
  bool isSelectionRow = false;
  bool isSelectionCell = false;
  bool isSingleSelection = false;
  bool canGoBack;
  bool showDatePicker;
  bool showPagination;
  bool showSelectionRowColor;
  int heightSizeBottom = 80;
  BuildContext? parent;
  int? total;
  void Function()? onTapRow;
  Widget? headerWidget;
  String? contentHeaderExcel;
  String? timeStartContentExcel;
  String? timeEndContentExcel;
  String? fileNameExcel;
  bool showOrdinalNumber;

  CustomDataTable({
    this.showExtension,
    required this.controller,
    required this.refresh,
    this.parent,
    this.bottomWidget,
    this.topWidget,
    this.headerWidget,
    this.showDatePicker = false,
    this.titleHeader,
    this.canGoBack = false,
    this.showPagination = true,
    this.isShowBottomWidget = false,
    this.showSelectionRowColor = true,
    this.total,
    this.isSelectionRow = false,
    this.isSelectionCell = false,
    this.isSingleSelection = false,
    this.isShowCheckbox = true,
    this.filterObjectActivating,
    this.onObjectActivated,
    this.heightSizeBottom = 80,
    this.onTapRow,
    this.showExport = false,
    this.getHeightRow,
    this.showBottomWidget = true,
    this.contentHeaderExcel,
    this.timeStartContentExcel,
    this.timeEndContentExcel,
    this.fileNameExcel,
    this.showOrdinalNumber = false,
  }) {
    if (showExtension != null) {
      _dataSource = CustomDataSource(
          parent: parent,
          controller: controller,
          showOrdinalNumber: showOrdinalNumber,
          isExtended: true,
          showExtension: showExtension,
          filterObjectActivating: filterObjectActivating,
          dataGridController: dataGridController);
    } else {
      _dataSource = CustomDataSource(
          parent: parent,
          controller: controller,
          isExtended: false,
          filterObjectActivating: filterObjectActivating,
          dataGridController: dataGridController,
          showOrdinalNumber: showOrdinalNumber);
    }
  }

  void setConfigSize(List<double> sizes) {
    _dataSource.setConfigSize(sizes);
  }

  void setConfigType(List<String> types) {
    _dataSource.setType(types);
  }

  void setData(List<T> data, List<T> dataEmpty) {
    _dataSource.setData(data, dataEmpty);
  }

  void setConfigFilter(List<bool> filters) {
    _dataSource.setConfigFilter(filters);
  }

  void setConfigSearch(List<String> search) {
    _dataSource.setConfigSearch(search);
  }

  void setConfigSort(List<bool> sort) {
    _dataSource.setConfigSort(sort);
  }

  Widget buildDataGrid() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          gridLineColor: ColorValueKey.tableBorder,
          selectionColor: showSelectionRowColor == true ? Colors.teal.withValues(alpha: 0.4) : Colors.transparent,
          filterIconColor: ColorValueKey.textColor,
          sortIconColor: ColorValueKey.textColor,
          headerColor: ColorValueKey.headerTableColor,
          currentCellStyle: const DataGridCurrentCellStyle(borderColor: Colors.transparent, borderWidth: 0)
          // sortIconColor: app_color.accountColor
          ),
      child: SfDataGrid(
        key: _dataGridKey,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        allowFiltering: true,
        allowSorting: true,
        allowMultiColumnSorting: true,
        isScrollbarAlwaysShown: true,
        showCheckboxColumn: isShowCheckbox,
        selectionMode: isSelectionRow
            ? (isSingleSelection ? SelectionMode.singleDeselect : SelectionMode.multiple)
            : (isSelectionCell ? SelectionMode.single : SelectionMode.none),
        navigationMode: isSelectionCell ? GridNavigationMode.cell : GridNavigationMode.row,
        source: _dataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: _dataSource.buildCol(),
        controller: dataGridController,
        onSelectionChanging: (List<DataGridRow> addedRows, List<DataGridRow> removedRows) {
          // final index = _employeeDataSource.dataGridRows.indexOf(addedRows.last);
          // Employee employee = _employees[index];
          // if (employee.designation == 'Manager') {
          //   return false;
          // }
          return true;
        },
        onSelectionChanged: (List<DataGridRow> addedRows, List<DataGridRow> removedRows) {
          _dataSource.removeSelectItem(removedRows);
          _dataSource.addSelectedItem(addedRows);
          if (onTapRow != null) {
            onTapRow!();
          }
        },
        // onCurrentCellActivating: isSelectionCell ? (RowColumnIndex currentRowColumnIndex, RowColumnIndex previousRowColumnIndex) {
        //   print("${currentRowColumnIndex}");
        //   print("${previousRowColumnIndex}");
        //   return true;
        // } : null,
        onCurrentCellActivating: isSelectionCell ? filterCellActivating : null,

        // selectionManager: _customSelectionManager,
        onQueryRowHeight: getHeightRow == null
            ? (details) {
                return details.getIntrinsicRowHeight(
                  details.rowIndex,
                  excludedColumns: ['screen', 'device', 'value', 'schedules'],
                );
              }
            : (details) {
                return getHeightRow!(details.rowIndex);
              },
      ),
    );
  }

  Widget drawTable(BuildContext context) {
    print("Draw Table");
    _dataSource.setData(controller.getItem(), controller.dataEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: topWidget ?? const SizedBox.shrink(),
        ),
        OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: headerWidget ?? const Offstage(),
            ),

            Container(
              width: 350,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
              child: CupertinoSearchTextField(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: ColorValueKey.lineBorder)),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: ColorValueKey.textColor,
                ),
                placeholder: 'Tìm kiếm',
                style: TextStyle(color: ColorValueKey.textColor),
                onChanged: (value) {
                  EasyDebounce.debounce('my-debouncer', const Duration(milliseconds: 200), () async {
                    controller.setSearch(value, _dataSource._search);
                    pageCount.value = controller.getCountPage().toDouble();
                    controller.clearFilter();
                    _dataSource.notifyListeners();
                  });
                },
              ),
            ),
            // showDatePicker ? CustomDatePicker(
            //   label: "Select date",
            //   onDateSelected: (onSelected) {
            //     print('User selected: $onSelected');
            //   },
            // ) : const SizedBox.shrink()
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Expanded(
          child: Column(
            children: [
              Divider(
                height: 1,
                thickness: 1,
                color: ColorValueKey.tableBorder,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  color: ColorValueKey.backgroundColor,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: buildDataGrid(),
                ),
              ),
              // Divider(height: 1, thickness: 1, color: app_color.tableBorder,),
              showPagination
                  ? SizedBox(
                      height: 0,
                      child: SfDataPagerTheme(
                        data: SfDataPagerThemeData(
                          backgroundColor: ColorValueKey.mainColor.withOpacity(0.5),
                          itemColor: ColorValueKey.textColor.withOpacity(0.5),
                          selectedItemColor: ColorValueKey.selectedColor,
                          disabledItemColor: ColorValueKey.textColor.withOpacity(0.25),

                          // backgroundColor: app_color.mainColor.withOpacity(0.5),
                          // itemColor: app_color.textColor.withOpacity(0.5),
                          // selectedItemColor: app_color.selectedColor,
                          // disabledItemColor: app_color.textColor.withOpacity(0.25),

                          itemTextStyle: TextStyle(
                            color: ColorValueKey.textColor,
                          ),
                        ),
                        child: Theme(
                            data: Theme.of(context).copyWith(canvasColor: ColorValueKey.backgroundColor),
                            child: ValueListenableBuilder(
                              valueListenable: pageCount,
                              builder: (context, value, child) {
                                return SfDataPager(
                                  delegate: _dataSource,
                                  availableRowsPerPage: const [100, 200, 400, 800],
                                  onRowsPerPageChanged: (int? rowsPerPage) {
                                    if (rowsPerPage != null) {
                                      controller.setNumberItemInPage(rowsPerPage);
                                      _dataSource.notifyListeners();
                                      pageCount.value = controller.getCountPage().toDouble();
                                    }
                                  },
                                  /*onPageNavigationEnd: (pageIndex) {
                              _restoreSelectedRows(pageIndex);
                            },*/
                                  pageCount: controller.getCountPage().toDouble(),
                                  direction: Axis.horizontal,
                                  visibleItemsCount: 5,
                                );
                              },
                            )),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        // Divider(
        //   height: 1,
        //   thickness: 1,
        //   color: ColorValueKey.tableBorder,
        // ),
        if (showBottomWidget) ...[
          const SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: ColorValueKey.tableBorder,
          ),
          Container(
            color: ColorValueKey.backgroundColor,
            height: 60,
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (titleHeader != null)
                  total == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: ValueListenableBuilder(
                            valueListenable: controller.totalData,
                            builder: (context, value, child) {
                              return Text(
                                '${titleHeader != '' ? '$titleHeader -' : ''} Dữ liệu: ${value.toString()}',
                                style: TextStyle(fontSize: 20, color: ColorValueKey.textColor),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Text(
                            '${titleHeader != '' ? '$titleHeader -' : ''} Dữ liệu: ${total.toString()}',
                            style: TextStyle(fontSize: 20, color: ColorValueKey.textColor),
                          ),
                        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    bottomWidget ?? const Offstage(),
                    RefreshButtonWidget(
                      onPressed: refresh,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

/*  void _restoreSelectedRows(int pageIndex) {
    if (controller.selectData != null) {
      if (controller.selectData!.isNotEmpty) {
        controller.setSelectDataTable();
        _dataSource.notifyListeners();
      }
    }
  }*/
}
