import 'package:shop_com/utils/app_color.dart';

class AppConfig {
  final List<ItemAppColor> store_color = [];
  String _selected_color = "";

  AppColor? get appColor {
    ItemAppColor? tmp = store_color.where((s) => s.code.compareTo(_selected_color) == 0).firstOrNull;
    if (tmp == null) {
      return null;
    } else {
      return tmp.keys;
    }
  }

}

final AppConfig app_config = AppConfig();