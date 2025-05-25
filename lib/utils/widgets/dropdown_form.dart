import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../color_value_key.dart';
import '../local_value_key.dart';

class DropdownForm extends StatefulWidget {
  const DropdownForm({
    super.key,
    this.items = const [],
    required this.onSaved,
    this.value,
    this.hintText,
    this.isVisibleClearButton = false,
    this.isRequired = true,
    this.enabled = true,
    this.title,
    this.asyncItems,
    this.allowSearch = true,
    this.onRefreshError,
    this.selectedFontSize,
  });

  final bool enabled;
  final List<Item> items;
  final Function(Item)? onSaved;
  final Item? value;
  final String? hintText;
  final double? selectedFontSize;
  final bool isVisibleClearButton;
  final bool isRequired;
  final String? title;
  final bool allowSearch;
  final Future<List<Item>> Function()? asyncItems;
  final Future Function()? onRefreshError;

  @override
  State<DropdownForm> createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  late String originalText;

  @override
  void initState() {
    originalText = _searchController.text;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Item>(
      compareFn: (Item a, Item b) => a.code == b.code,
      items: (filter, loadProps) {
        if (widget.asyncItems != null) {
          return widget.asyncItems!.call();
        }
        return widget.items;
      },
      enabled: widget.enabled,

      validator: widget.isRequired
          ? (value) {
              if (value == null || value.name == "") {
                return LocalValueKey.pleaseFillInfo;
              }
              return null;
            }
          : null,
      selectedItem: widget.value?.code != "" ? widget.value : null,
      itemAsString: (Item? item) => item?.name ?? '',
      onChanged: (value) {
        widget.onSaved!(value ?? Item(name: '', code: ''));
      },
      suffixProps: DropdownSuffixProps(
        clearButtonProps: ClearButtonProps(
          color: ColorValueKey.textColor,
          isVisible: widget.isVisibleClearButton,
        ),
      ),
      dropdownBuilder: (context, selectedItems) {
        if (selectedItems == Item(name: '', code: '')) {
          return const Offstage();
        }

        return RawScrollbar(
          trackVisibility: false,
          thumbVisibility: true,
          controller: _scrollController,
          padding: EdgeInsets.zero,
          crossAxisMargin: 0,
          thickness: 4,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Text(
                selectedItems?.name ?? '',
                style: TextStyle(
                  color: ColorValueKey.textColor,
                  fontSize: widget.selectedFontSize,
                ),
              ),
            ),
          ),
        );
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: widget.hintText != null
            ? InputDecoration(
                label: Text.rich(
                  TextSpan(
                    style: TextStyle(color: ColorValueKey.textColor),
                    text: widget.hintText,
                    children: widget.isRequired
                        ? [
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                        : null,
                  ),
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorValueKey.lineBorder),
                ),
            hintText: widget.hintText,
                errorStyle: TextStyle(color: ColorValueKey.errorTextColor))
            :  InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: const OutlineInputBorder(),
            errorStyle:  TextStyle(color: ColorValueKey.errorTextColor)

        ),
      ),
      popupProps: PopupPropsMultiSelection.menu(
        itemBuilder: (context, item, isSelected, isDisabled) {
          return ListTile(
            title: Text(
              item.name,
              style: TextStyle(color: ColorValueKey.textColor),
            ),
          );
        },
        menuProps: MenuProps(
          backgroundColor: ColorValueKey.backgroundColor,
        ),
        title: widget.title != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorValueKey.textColor,
                  ),
                ),
              )
            : const Offstage(),
        emptyBuilder: (context, searchEntry) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  LocalValueKey.noData,
                  style: TextStyle(
                    color: ColorValueKey.textColor,
                  ),
                ),
              ),
            ],
          );
        },
        errorBuilder: (context, searchEntry, exception) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                textAlign: TextAlign.center,
                LocalValueKey.someErrorOccur,
                style: TextStyle(color: ColorValueKey.textColor),
              ),
              if (widget.onRefreshError != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    onPressed: () async {
                      _searchController.text = '      ';
                      widget.onRefreshError!().whenComplete(
                        () => _searchController.text = originalText,
                      );
                    },
                    label: Text(LocalValueKey.refresh),
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  ),
                ),
            ],
          );
        },
        searchDelay: const Duration(milliseconds: 0),
        showSearchBox: widget.allowSearch,
        searchFieldProps: TextFieldProps(
          controller: _searchController,
        ),
        fit: FlexFit.loose,
        scrollbarProps: const ScrollbarProps(
          thumbVisibility: true,
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String code;

  Item({required this.name, required this.code, });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };

  @override
  String toString() => name;
}
