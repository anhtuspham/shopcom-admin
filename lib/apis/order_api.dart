import 'package:async/async.dart';
import 'package:shop_com/apis/base_api.dart';

import '../data/config/app_config.dart';
import '../data/model/cart.dart';
import '../data/model/order.dart';

mixin OrderApi on BaseApi {
  Future<List<Order>> fetchOrder() async {
    Result result = await handleRequest(request: () {
      return get('/api/order/my-orders');
    });

    try {
      List rawList = result.asValue!.value;
      return safeParseOrders(rawList);
    } catch (e) {
      return [];
    }
  }

  List<Order> safeParseOrders(List rawList) {
    return rawList
        .map<Order?>((e) {
      try {
        return Order.fromJson(e);
      } catch (err) {
        app_config.printLog("e", " API_USER_FETCH_ORDER : ${err.toString()} \n Item: $e");
        // print('❌ Lỗi khi parse product: $err\nRaw item: $e');
        return null;
      }
    })
        .whereType<Order>()
        .toList();
  }

  Future<Result> createOrder() async {
    return handleRequest(request: () => post('/api/order'));
  }

  Future<Order> fetchOrderDetail({required String orderId}) async {
    Result result = await handleRequest(request: () async {
      return get('/api/order/get-order/$orderId');
    });
    try {
      return Order.fromJson(result.asValue!.value);
    } catch (_) {
      return Order.empty();
    }
  }

// Future<Result> removeProductFromOrder({
//   required String productId,
//   required int variantIndex,
// }) {
//   return handleRequest(
//     request: () => post('api/cart/remove-product-cart', data: {
//       "productId": productId,
//       "variantIndex": variantIndex,
//     }),
//   );
// }
}
