
import 'package:async/async.dart';
import 'package:shop_com/data/model/auth_user.dart';

import '../data/config/app_config.dart';

class AuthProvider {
  AuthProvider() : super();

  Future<AuthUser?> login(String email, String password) async {
    AuthUser? appUser = await api.login(email, password);
    if (appUser != null) {
      app_config.user = appUser;
      // await app_config.saveUser();
      return appUser;
    }
    return appUser;
  }

  // Future<bool> renewToken() async {
  //   AuthUser? appUser = app_config.user;
  //   if (appUser != null) {
  //     AuthUser? tmp = await api.renewToken(appUser.token);
  //     if (tmp != null && tmp.token.isNotEmpty) {
  //       app_config.user = tmp;
  //       await app_config.saveUser();
  //       reloadApiUrl();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  Future<Result> changePassword({ required String confirmPassword, required String oldPassword,required String newPassword}) async {
    final result = await api.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword ,
      confirmPassword: confirmPassword,
    );
    return result;
  }
}
