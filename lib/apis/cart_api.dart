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

  Future<Result> addProductToCart(
      {required String productId,
      required int variantIndex,
      required int quantity}) async {
    return handleRequest(
        request: () => post('/api/cart/add-product-cart', data: {
              "productId": productId,
              "variantIndex": variantIndex,
              "quantity": quantity
            }));
  }

  Future<Result> removeProductFromCart(
      {required String productId,
      required int variantIndex,
      required int quantity}) {
    return handleRequest(
      request: () => delete('api/cart/remove-product-cart', data: {
        "productId": productId,
        "variantIndex": variantIndex,
        "quantity": quantity
      }),
    );
  }
}
