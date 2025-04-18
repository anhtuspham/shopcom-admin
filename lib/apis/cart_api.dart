import 'package:async/async.dart';
import 'package:shop_com/apis/base_api.dart';

import '../data/model/cart.dart';

mixin CartApi on BaseApi {
  Future<Cart> fetchCart() async {
    Result result = await handleRequest(request: () {
      return get('/api/cart/get');
    });

    try {
      return Cart.fromJson(result.asValue!.value);
    } catch (e) {
      return Cart.empty();
    }
  }
}
