import 'package:dio/dio.dart';

import '../data/model/user.dart';
import 'base_api.dart';
import 'package:async/async.dart';

mixin UserApi on BaseApi {
  Future<List<User>> fetchUsers() async {
    Result result = await handleRequest(
      request: () async {
        return get('/User/list');
      },
    );
    try {
      final List rawList = result.asValue!.value;
      return rawList.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Result> createUser({
    required String code,
    required String username,
    required String name,
    required String password,
    required String des,
    required String role,
    required String phone,
  }) async {
    return handleRequest(
      request: () => post(
        '/User/create',
        data: {
          'code': code,
          'username': username,
          'name': name,
          'password': password,
          'des': des,
          'role': role,
          'phone': phone,
        },
      ),
    );
  }

  Future<Result> editUser({
    required String code,
    required String name,
    required String password,
    required String des,
    required String role,
    required String phone,
  }) async {
    return handleRequest(
      request: () => put(
        '/User/edit/$code',
        data: {
          'name': name,
          'password': password,
          'des': des,
          'role': role,
          'phone': phone,
        },
      ),
    );
  }


  Future<Result> changePassword({
    required String confirmPassword,
    required String oldPassword,
    required String newPassword
  }) async {
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
}
