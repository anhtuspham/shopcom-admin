
import 'package:shop_com/apis/base_api.dart';
import 'package:shop_com/data/model/product.dart';
import 'package:async/async.dart';

import '../data/config/app_config.dart';

mixin FavoriteApiApi on BaseApi {
  Future<List<Product>> fetchFavoriteProduct() async{
    Result result = await handleRequest(
      request: () async {
        return get('/api/favorite/get-favorite-products');
      },
    );
    try {
      final List rawList = result.asValue!.value;
      return safeParseProducts(rawList);
    } catch (e) {
      return [];
    }
  }

  List<Product> safeParseProducts(List rawList) {
    return rawList
        .map<Product?>((e) {
      try {
        return Product.fromJson(e);
      } catch (err) {
        app_config.printLog("e", " API_USER_FETCH_FAVORITE_PRODUCT : ${err.toString()} ");
        return null;
      }
    })
        .whereType<Product>()
        .toList();
  }

  Future<Result> addProductFavorite(
      {required String productId,}) async {
    return handleRequest(
        request: () => post('/api/favorite/add-favorite/', data: {
          "productId": productId,
        }));
  }

  Future<Result> removeProductFavorite({
    required String productId,
  }) {
    return handleRequest(
      request: () => delete('api/favorite/remove-favorite', data: {
        "productId": productId,
      }),
    );
  }
}
