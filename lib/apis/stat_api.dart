import 'package:async/async.dart';
import 'package:shop_com_admin_web/apis/base_api.dart';
import 'package:shop_com_admin_web/data/model/order_month.dart';
import 'package:shop_com_admin_web/data/model/order_status.dart';
import 'package:shop_com_admin_web/data/model/revenue_category.dart';
import 'package:shop_com_admin_web/data/model/revenue_month.dart';

import '../data/model/dashboard_stat.dart';

mixin StatApi on BaseApi {
  Future<List<RevenueMonth>> getRevenueByMonth() async {
    Result result = await handleRequest(
      request: () async {
        return get('/api/admin/stat/revenue-by-month');
      },
    );
    try {
      List rawList = result.asValue!.value;
      return rawList.map((e) => RevenueMonth.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<OrderStatus>> getOrderStatus() async {
    Result result = await handleRequest(
      request: () {
        return get('/api/admin/stat/order-status');
      },
    );
    try {
      List rawList = result.asValue!.value;
      return rawList.map((e) => OrderStatus.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<RevenueCategory>> getRevenueCategory() async {
    Result result = await handleRequest(
      request: () {
        return get('/api/admin/stat/revenue-by-category');
      },
    );
    try {
      List rawList = result.asValue!.value;
      return rawList.map((e) => RevenueCategory.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<OrderMonth>> getOrderMonth() async {
    Result result = await handleRequest(
      request: () {
        return get('/api/admin/stat/orders-by-month');
      },
    );
    try {
      List rawList = result.asValue!.value;
      return rawList.map((e) => OrderMonth.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<DashboardStat> getDashboardStats() async {
    Result result = await handleRequest(
      request: () {
        return get('/api/admin/stat/dashboard-stat');
      },
    );
    try {
      final data = result.asValue!.value;
      return DashboardStat.fromJson(data);
    } catch (e) {
      return DashboardStat(
        totalRevenue: 0,
        totalOrders: 0,
        totalUsers: 0,
        totalProducts: 0,
      );
    }
  }
}
