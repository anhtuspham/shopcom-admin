import 'package:async/async.dart';
import 'package:shop_com/apis/base_api.dart';

import '../data/model/cart.dart';
import '../data/model/order.dart';

mixin OrderApi on BaseApi {
  Future<Order> fetchOrder() async {
    Result result = await handleRequest(request: () {
      return get('/api/order/my-orders');
    });

    try {
      return Order.fromJson(result.asValue!.value);
    } catch (e) {
      return Order.empty();
    }
  }

  Future<Result> createOrder() async {
    return handleRequest(request: () => post('/api/order'));
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
