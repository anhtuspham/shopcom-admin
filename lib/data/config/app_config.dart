import 'package:logger/logger.dart';
import 'package:shop_com/data/model/auth_user.dart';
import 'package:shop_com/providers/auth_provider.dart';
import 'package:shop_com/utils/app_color.dart';

import '../../apis/base_api.dart';
import '../../utils/app_value_key.dart';

final logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(
    methodCount: 2,
    // Number of method calls to be displayed
    errorMethodCount: 8,
    // Number of method calls if stacktrace is provided
    lineLength: 120,
    // Width of the output
    colors: true,
    // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
  ), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
);

class AppConfig {
  final List<ItemAppColor> store_color = [];
  String _selected_color = "";

  AuthUser? _user;

  AuthUser? get user => _user;

  void set user(AuthUser? tmp) {
    _user = tmp;
  }

  AppColor? get appColor {
    ItemAppColor? tmp = store_color
        .where((s) => s.code.compareTo(_selected_color) == 0)
        .firstOrNull;
    if (tmp == null) {
      return null;
    } else {
      return tmp.keys;
    }
  }

  void printLog(String type, String txt) {
    switch (type) {
      case "i":
        logger.i(txt);
        break;
      case "d":
        logger.d(txt);
        break;
      case "e":
        logger.e(txt);
        break;
      default:
        logger.i(txt);
        break;
    }
  }
}

final AppConfig app_config = AppConfig();
final AuthProvider userController = AuthProvider();
Api api = Api();
