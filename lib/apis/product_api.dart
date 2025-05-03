import 'package:shop_com/apis/base_api.dart';
import 'package:shop_com/data/model/product.dart';
import 'package:async/async.dart';

import '../data/config/app_config.dart';

mixin ProductApi on BaseApi {
  Future<List<Product>> fetchProduct({String? sortBy}) async {
    Result result = await handleRequest(
      request: () async {
        return get('/api/Products', queryParameters: {"sort": sortBy});
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
            app_config.printLog("e", " API_USER_FETCH_PRODUCT : ${err.toString()} ");
            return null;
          }
        })
        .whereType<Product>()
        .toList();
  }

  Future<Product> fetchProductDetail({required String id}) async {
    Result result = await handleRequest(request: () async {
      return get('/api/product/$id');
    });
    try {
      return Product.fromJson(result.asValue!.value);
    } catch (_) {
      return Product.empty();
    }
  }
}
