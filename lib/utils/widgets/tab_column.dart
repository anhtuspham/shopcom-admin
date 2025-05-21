import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_color.dart';
import '../app_value_key.dart';

class TabColItem extends ConsumerWidget {
  final String title;
  final bool isSelected;
  final AppKeyValue app_text;
  final AppColor app_color;

  const TabColItem({super.key, required this.title, this.isSelected = false, required this.app_text, required this.app_color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        context.goNamed(title);
        // List<MenuItem>? _items = getAppConfigMenuFromStore();
        // if(_items != null && _items.isNotEmpty) {
        //   MenuItem? _item = _items.where((s) => s.code != null && s.code != null && s.code!.compareTo(title) == 0).firstOrNull;;
        //   if(_item != null) {
        //     context.goNamed(_item!.code!);
        //   }
        // }
      },
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: const Border.symmetric(
            vertical: BorderSide(color: Colors.grey, width: 0.5),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isSelected ? [app_color.selectedColor, app_color.selectedColor2] : [app_color.btnTextColor, app_color.btnTextColor],
          ),
        ),
        child: Text(
          app_text.getValue(title)??title,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: app_color.textColor,
          ),
        ),
      ),
    );
  }
}