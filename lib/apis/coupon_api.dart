import 'package:dio/dio.dart';
import 'package:shop_com_admin_web/data/config/app_config.dart';

import '../data/model/coupon.dart';
import 'base_api.dart';
import 'package:async/async.dart';

mixin CouponApi on BaseApi {
  Future<List<Coupon>> fetchCoupons() async {
    Result result = await handleRequest(
      request: () async {
        return get('/api/admin/coupon');
      },
    );
    try {
      final List rawList = result.asValue!.value;
      return rawList.map((e) => Coupon.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Result> createCoupon(
      {String? code,
      String? discountType,
      int? discountValue,
      int? minOrderValue,
      int? maxDiscountAmount,
      DateTime? expirationDate,
      int? usageLimit}) async {
    return handleRequest(
      request: () => post(
        '/api/admin/coupon',
        data: {
          'code': code,
          'discountType': discountType,
          'discountValue': discountValue,
          'minOrderValue': minOrderValue,
          'maxDiscountAmount': maxDiscountAmount,
          'expirationDate': expirationDate,
          'usageLimit': usageLimit,
        },
      ),
    );
  }

  Future<Result> editCoupon(
      {String? id,
      String? code,
      String? discountType,
      int? discountValue,
      int? minOrderValue,
      int? maxDiscountAmount,
      DateTime? expirationDate,
      int? usageLimit}) async {
    return handleRequest(
      request: () => put(
        '/api/admin/coupon/$id',
        data: {
          'code': code,
          'discountType': discountType,
          'discountValue': discountValue,
          'minOrderValue': minOrderValue,
          'maxDiscountAmount': maxDiscountAmount,
          'expirationDate': expirationDate,
          'usageLimit': usageLimit,
        },
      ),
    );
  }

  Future<Result> deleteCoupon({required String id}) async {
    return handleRequest(
      request: () => delete(
        '/api/admin/coupon/$id',
      ),
    );
  }
}
