import 'package:dio/dio.dart';
import 'package:shop_com_admin_web/data/config/app_config.dart';

import '../data/model/user.dart';
import 'base_api.dart';
import 'package:async/async.dart';

mixin UserApi on BaseApi {
  Future<List<User>> fetchUsers() async {
    Result result = await handleRequest(
      request: () async {
        return get('/api/admin/user/get-all-user');
      },
    );
    try {
      final List rawList = result.asValue!.value;
      return rawList.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<User> getUserInfo() async {
    Result result = await handleRequest(
      request: () => get('/api/users/profile'),
    );
    try {
      return User.fromJson(result.asValue!.value);
    } catch (e) {
      app_config.printLog("e", " API_FETCH_USER_INFO : ${e.toString()}");
      return User.empty();
    }
  }

  Future<Result> createUser(
      {String? name, String? email, String? password, String? address, bool? isAdmin}) async {
    return handleRequest(
      request: () => post(
        '/api/admin/user/create',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'address': address,
          'isAdmin': isAdmin,
        },
      ),
    );
  }

  Future<Result> editUser({
    required String id,
    String? email,
    String? name,
    String? password,
    String? address,
    bool? isAdmin
  }) async {
    return handleRequest(
      request: () => post(
        '/api/admin/user/update',
        data: {
          'id': id,
          'email': email,
          'name': name,
          'password': password,
          'address': address,
          'isAdmin': isAdmin
        },
      ),
    );
  }

  Future<Result> updateUserRole({String? id, bool? isAdmin}) async {
    return handleRequest(
      request: () => put(
        '/api/admin/user/role',
        data: {'id': id, 'isAdmin': isAdmin},
      ),
    );
  }

  Future<Result> changePassword(
      {required String confirmPassword,
      required String oldPassword,
      required String newPassword}) async {
    return handleRequest(
      request: () => put(
        '/User/changePassword',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword
        },
      ),
    );
  }

  Future<Result> deleteUser(
      {required String id}) {
    return handleRequest(
      request: () => delete(
        '/api/admin/user/$id',
      ),
    );
  }
}
